# PyZX - Python library for quantum circuit rewriting 
#        and optimisation using the ZX-calculus
# Copyright (C) 2018 - Aleks Kissinger and John van de Wetering

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

"""Contains simplification procedures based in the rewrite rules in rules_.
"""

from __future__ import print_function

try:
    import multiprocessing as mp
except ImportError:
    pass

__all__ = ['bialg_simp','spider_simp', 'id_simp', 'phase_free_simp', 'pivot_simp', 'gadget_simp',
        'lcomp_simp', 'clifford_simp', 'tcount', 'to_gh', 'to_rg', 'full_reduce', 'pivot_double_boundary']

from .rules import *

def simp(g, name, match, rewrite, matchf=None, quiet=False):
    """Helper method for generating simplification strategies based on rules in rules_.
    It keeps matching and rewriting with the given methods until it can no longer do so.
    Example usage: ``simp(g, 'spider_simp', rules.match_spider_parallel, rules.spider)``

    :param g: The graph that needs to be simplified.
    :param str name: The name of this rewrite rule.
    :param match: One of the ``match_*`` functions of rules_.
    :param rewrite: One of the rewrite functions of rules_.
    :param matchf: An optional filtering function on candidate vertices or edges, which
       is passed as the second argument to the match function.
    :param quiet: Suppress output on numbers of matches found during simplification."""
    i = 0
    new_matches = True
    while new_matches:
        new_matches = False
        if matchf != None:
            m = match(g, matchf)
        else:
            m = match(g)
        if len(m) > 0:
            i += 1
            if i == 1 and not quiet: print("{}: ".format(name),end='')
            if not quiet: print(len(m), end='')
            #print(len(m), end='', flush=True) #flush only supported on Python >3.3
            etab, rem_verts, rem_edges, check_isolated_vertices = rewrite(g, m)
            g.add_edge_table(etab)
            g.remove_edges(rem_edges)
            g.remove_vertices(rem_verts)
            if check_isolated_vertices: g.remove_isolated_vertices()
            if not quiet: print('. ', end='')
            #print('. ', end='', flush=True)
            new_matches = True
    if not quiet and i>0: print(' {!s} iterations'.format(i))
    return i

def pivot_simp(g, matchf=None, quiet=False):
    return simp(g, 'pivot_simp', match_pivot_parallel, pivot, matchf=matchf, quiet=quiet)

def pivot_gadget_simp(g, matchf=None, quiet=False):
    return simp(g, 'pivot_gadget_simp', match_pivot_gadget, pivot, matchf=matchf, quiet=quiet)

def lcomp_simp(g, matchf=None, quiet=False):
    return simp(g, 'lcomp_simp', match_lcomp_parallel, lcomp, matchf=matchf, quiet=quiet)

def bialg_simp(g, quiet=False):
    return simp(g, 'bialg_simp', match_bialg_parallel, bialg, quiet=quiet)

def spider_simp(g, matchf=None, quiet=False):
    return simp(g, 'spider_simp', match_spider_parallel, spider, matchf=matchf, quiet=quiet)

def id_simp(g, matchf=None, quiet=False):
    return simp(g, 'id_simp', match_ids_parallel, remove_ids, matchf=matchf, quiet=quiet)

def gadget_simp(g, quiet=False):
    return simp(g, 'gadget_simp', match_phase_gadgets, merge_phase_gadgets, quiet=quiet)

def phase_free_simp(g, quiet=False):
    '''Performs the following set of simplifications on the graph:
    spider -> bialg'''
    spider_simp(g, quiet=quiet)
    bialg_simp(g, quiet=quiet)

def interior_clifford_simp(g, quiet=False):
    """Keeps doing the simplifications id_simp, spider_simp, pivot_simp and lcomp_simp
    until none of them can be applied anymore."""
    spider_simp(g, quiet=quiet)
    to_gh(g)
    i = 0
    while True:
        i1 = id_simp(g, quiet=quiet)
        i2 = spider_simp(g, quiet=quiet)
        i3 = pivot_simp(g, quiet=quiet)
        i4 = lcomp_simp(g, quiet=quiet)
        if i1+i2+i3+i4==0: break
        i += 1
    return i

def clifford_simp(g, quiet=False):
    """Keeps doing rounds of :func:`interior_clifford_simp` and
    :func:`pivot_double_boundary` until they can't be applied anymore."""
    while True:
        interior_clifford_simp(g, quiet=quiet)
        i = pivot_double_boundary(g, quiet=quiet)
        if i == 0:
            break

def pivot_double_boundary(g, quiet=False):
    """Finds Pauli-phase interior non-phase gadget nodes that are connected
    to the boundary. It changes the boundary nodes so that a pivot can be done
    to remove the interior Pauli node."""
    phases = g.phases()
    ty = g.types()
    qs = g.qubits()
    rs = g.rows()
    pivotable_edges = []
    skiplist = []
    for v in list(g.vertices()):
        if v in skiplist: continue
        if ty[v] != 1 or phases[v] not in (0,1): continue
        good_vert = True
        for w in g.neighbours(v):
            if ty[w] != 1: 
                good_vert = False
                break
            if len(list(g.neighbours(w))) == 1: # v is a phase gadget
                good_vert = False
                break
        if not good_vert: continue
        #if any(ty[w]!=1 for w in g.neighbours(v)): continue

        # v is now an interior edge with a 0/1 phase
        for e in g.incident_edges(v):
            s,t = g.edge_st(e)
            v2 = s if s!=v else t
            borders = sum(1 for w in g.neighbours(v2) if ty[w]==0)
            #if phases[v2] not in (0,1): continue
            if phases[v2] in (Fraction(1,2), Fraction(3,2)):
                if borders != 1: continue
                # v2 is a node on the border with a pi/2 phase
                w = g.add_vertex(1,-1, rs[v2], phase=-phases[v2])
                g.add_edge((v2,w),2)
                g.set_phase(v2, 0)
                skiplist.append(v2)
                pivotable_edges.append(e)
                continue
            elif phases[v2] not in (0,1): continue 
            if borders > 1:
                i = next(w for w in g.neighbours(v2) if w in g.inputs)
                o = next(w for w in g.neighbours(v2) if w in g.outputs)
                w1 = g.add_vertex(1,qs[i], rs[i]+1)
                w2 = g.add_vertex(1,qs[o], rs[o]-1)
                e1 = g.edge(v2,i)
                e2 = g.edge(v2,o)
                et1 = g.edge_type(e1)
                et2 = g.edge_type(e2)
                g.remove_edges([e1,e2])
                g.add_edges([(v2,w1),(v2,w2)],2)
                g.add_edge((i,w1),3-et1)
                g.add_edge((o,w2),3-et2)
            skiplist.append(v2)
            pivotable_edges.append(e)
    if not quiet and pivotable_edges: 
        print("Boundary Pivot: Unfused {:d} nodes for {:d} possible pivots".format(
                                len(skiplist),len(pivotable_edges)))
    i = pivot_simp(g, matchf=lambda e: e in pivotable_edges, quiet=quiet)
    return i



def to_gh(g,quiet=True):
    """Turns every red node into a green node by changing regular edges into hadamard edges"""
    ty = g.types()
    for v in g.vertices():
        if ty[v] == 2:
            g.set_type(v, 1)
            for e in g.incident_edges(v):
                et = g.edge_type(e)
                if et == 2: g.set_edge_type(e,1)
                elif et == 1: g.set_edge_type(e,2)

def to_rg(g, select=None):
    """Turn green nodes into red nodes by colour-changing vertices which satisfy the predicate ``select``.
    By default, the predicate is set to greedily reducing the number of Hadamard-edges.
    :param g: A ZX-graph.
    :param select: A function taking in vertices and returning ``True`` or ``False``."""
    if not select:
        select = lambda v: (
            len([e for e in g.incident_edges(v) if g.edge_type(e) == 1]) <
            len([e for e in g.incident_edges(v) if g.edge_type(e) == 2])
            )

    ty = g.types()
    for v in g.vertices():
        if select(v):
            if ty[v] == 1:
                g.set_type(v, 2)
                for e in g.incident_edges(v):
                    g.set_edge_type(e, 1 if g.edge_type(e) == 2 else 2)
            elif ty[v] == 2:
                g.set_type(v, 1)
                for e in g.incident_edges(v):
                    g.set_edge_type(e, 1 if g.edge_type(e) == 2 else 2)


def full_reduce(g, quiet=True):
    interior_clifford_simp(g, quiet=quiet)
    while True:
        pivot_gadget_simp(g,quiet=quiet)
        clifford_simp(g,quiet=quiet)
        i = gadget_simp(g, quiet=quiet)
        interior_clifford_simp(g,quiet=quiet)
        if not i:
            break

# def gadgetize(g):
#     """Un-fuses every node with a non-Pauli phase, so that they act like phase gadgets. 
#     It returns a 2-tuple where the first value is the set of newly made gadgets,
#     and the second is the set of all gadgets in the graph.
#     The vertices returned are the 'hub' part of the phase gadget
#      (the part which can only contain a Pauli-phase)."""
#     phases = g.phases()
#     #qs = g.qubits()
#     rs = g.rows()
#     qs = g.qubits()
#     edges = []
#     allgadgets = []
#     newgadgets = []
#     for v in list(g.vertices()):
#         if phases[v] != 0 and phases[v].denominator > 1:
#             if len(list(g.neighbours(v))) == 1: # It is already a gadget
#                 allgadgets.append(v)
#                 continue
#             v1 = g.add_vertex(1,-1,rs[v]+0.5,0)
#             v2 = g.add_vertex(1,-2,rs[v]+0.5,phases[v])
#             # v1 = g.add_vertex(1,-2*qs[v]-1,rs[v]+0.5,0)
#             # v2 = g.add_vertex(1,-2*qs[v]-2,rs[v]+0.5,phases[v])
#             g.set_phase(v, 0)
#             edges.append((v,v1))
#             edges.append((v1,v2))
#             newgadgets.append(v1)
#             allgadgets.append(v1)
#     g.add_edges(edges, 2)
#     return set(newgadgets), set(allgadgets)

# def full_reduce(g, quiet=True):
#     """This function does a round of :func:`clifford_simp`, :func:`gadgetize` 
#     and then a modified round of `clifford_simp`. It then applies 
#     :func:`gadget_simp`. It keeps doing rounds of these simplifications
#     until no more progress is made."""
#     i = 0
#     gadgetcount = 10**10
#     vertexcount = 10**10
#     while True:
#         clifford_simp(g,quiet=quiet)
#         #if tcount(g) == 24: break
#         newgadgets, allgadgets = gadgetize(g)
#         if i == 0 and not newgadgets: break
#         if len(newgadgets) >= gadgetcount:
#             n = g.num_vertices()
#             if n >= vertexcount:
#                 clifford_simp(g,quiet=quiet)
#                 break
#             vertexcount = n
#         else:
#             vertexcount = g.num_vertices()
#         if not quiet: 
#             print("Vertex count: ", vertexcount)
#             print("T-count: ", tcount(g))

#         gadgetcount = len(newgadgets)
#         if not quiet and gadgetcount: print("Gadgetized {:d} nodes".format(gadgetcount))
#         # don't pivot an edge adjacent to a gadget vertex
#         def matchf(e):
#             s, t = g.edge_st(e)
#             if s in newgadgets or t in newgadgets:
#                 return False
#             if s in allgadgets and t in allgadgets:
#                 return False
#             return True
#         #matchf = lambda e: g.edge_s(e) not in newgadgets and g.edge_t(e) not in newgadgets
#         #matchf = lambda e: not (g.edge_s(e) in gadgets or g.edge_t(e) in gadgets)
#         pivot_simp(g,matchf=matchf,quiet=quiet)
#         lcomp_simp(g,quiet=quiet)
#         pivot_simp(g,matchf=matchf,quiet=quiet)
#         phases = g.phases()
#         for v in g.vertices():
#             if phases[v] != 0 and phases[v].denominator > 2 and len(list(g.neighbours(v)))==1:
#                 n = list(g.neighbours(v))[0]
#                 if phases[n] == 1:
#                     g.set_phase(n, 0)
#                     g.set_phase(v, -1*phases[v])
#                     phases[n] = 0
#         if not quiet and gadgetcount: print("Back to clifford_simp")
#         clifford_simp(g,quiet=quiet)
#         i = gadget_simp(g, quiet=quiet)


def tcount(g):
    """Returns the amount of nodes in g that have a non-Clifford phase."""
    if not hasattr(g, "vertices"): # It is probably a circuit
        return g.tcount()
    count = 0
    phases = g.phases()
    for v in g.vertices():
        if phases[v]!=0 and phases[v].denominator > 2:
            count += 1
    return count


def simp_iter(g, name, match, rewrite):
    """Version of :func:`simp` that instead of performing all rewrites at once, returns an iterator."""
    i = 0
    new_matches = True
    while new_matches:
        i += 1
        new_matches = False
        m = match(g)
        if len(m) > 0:
            etab, rem_verts, rem_edges, check_isolated_vertices = rewrite(g, m)
            g.add_edge_table(etab)
            g.remove_edges(rem_edges)
            g.remove_vertices(rem_verts)
            if check_isolated_vertices: g.remove_isolated_vertices()
            yield g, name+str(i)
            new_matches = True

def pivot_iter(g):
    return simp_iter(g, 'pivot', match_pivot_parallel, pivot)

def lcomp_iter(g):
    return simp_iter(g, 'lcomp', match_lcomp_parallel, lcomp)

def bialg_iter(g):
    return simp_iter(g, 'bialg', match_bialg_parallel, bialg)

def spider_iter(g):
    return simp_iter(g, 'spider', match_spider_parallel, spider)

def id_iter(g):
    return simp_iter(g, 'id', match_ids_parallel, remove_ids)

def clifford_iter(g):
    for d in spider_iter(g): yield d
    to_gh(g)
    yield g, "to_gh"
    for d in spider_iter(g): yield d
    for d in pivot_iter(g): yield d
    for d in lcomp_iter(g): yield d
    for d in pivot_iter(g): yield d
    #to_rg(g)
    #yield g, "to_rg"
    for d in id_iter(g): yield d
    for d in spider_iter(g): yield d




def _worker(arg):
    match, rewrite, g, kwargname, kwarg = arg
    m =  match(g, **{kwargname:kwarg})
    if m: return (len(m),rewrite(g, m))
    return None

def simp_threaded(g, name, match, rewrite, uses_verts=False,safe=False,skip_unthreaded_pass=False):
    """Version of :func:`simp` that uses :mod:`multiprocessing`."""
    nthreads = 5
    i = 0
    new_matches = True
    sep = int(g.vindex / nthreads) + 1 #TODO: currently only works on graph_s
    pool = mp.Pool(processes=nthreads)
    #Threaded pass
    print("Starting {} with {} threads".format(name,str(nthreads)))
    while new_matches:
        new_matches = False
        if uses_verts:
            chunks = [set(g.vertices_in_range(j*sep,(j+1)*sep)) for j in range(nthreads)]
            for j in range(nthreads-1):
                if chunks[j] & chunks[j+1]:
                    raise Exception("overlapping chunks")
            results = pool.map(_worker, ((match, rewrite, g, "vertexlist", chunks[j]) for j in range(nthreads)),
                                        #set(g.vertices_in_range(j*sep,(j+1)*sep))) for j in range(nthreads)),
                                chunksize=1)
        else:
            chunks = [set(g.edges_in_range(j*sep,(j+1)*sep,safe)) for j in range(nthreads)]
            for j in range(nthreads-1):
                if chunks[j] & chunks[j+1]:
                    raise Exception("overlapping chunks")
            results = pool.map(_worker, ((match, rewrite, g, "edgelist", chunks[j]) for j in range(nthreads)),
                                        #set(g.edges_in_range(j*sep,(j+1)*sep,safe))) for j in range(nthreads)),
                                chunksize=1)

        check_isolated_vertices = False
        for j,r in enumerate(results):
            if not r: continue
            new_matches = True
            amount, (etab, rem_verts, rem_edges, check) = r
            print(amount, end=',')
            if uses_verts and not chunks[j].issuperset(set(rem_verts)):
                raise Exception("Deleting vertices outside of chunk: ", chunks[j], set(rem_verts))
            else:
                for v in rem_verts:
                    if not (j*sep<v<(j+1)*sep):
                        raise Exception("Deleting vertices outside of chunk")
            g.add_edge_table(etab)
            g.remove_edges(rem_edges)
            g.remove_vertices(rem_verts)
            check_isolated_vertices = check
        if check_isolated_vertices: g.remove_isolated_vertices() 
        if new_matches: i += 1
        print('. ', end='')
    pool.close()
    #Unthreaded pass
    if not skip_unthreaded_pass:
        new_matches = True
        if i!=0: print("\nUnthreaded pass: ", end='')
        else: print("Unthreaded pass: ", end='') 
        while new_matches:
            new_matches = False
            m = match(g)
            if len(m) > 0:
                print(len(m), end='')
                etab, rem_verts, rem_edges, check_isolated_vertices = rewrite(g, m)
                g.add_edge_table(etab)
                g.remove_edges(rem_edges)
                g.remove_vertices(rem_verts)
                if check_isolated_vertices: g.remove_isolated_vertices()
                print('. ', end='')
                new_matches = True
            if new_matches: i += 1
    if i!=0:  print('\nDid ' + str(i) + ' nonzero iterations')
    else: print('Did ' + str(i) + ' nonzero iterations')


def pivot_threaded(g):
    return simp_threaded(g, 'pivot_simp', match_pivot_parallel, pivot, uses_verts=False,safe=True)

def lcomp_threaded_old(g):
    simp_threaded(g, 'lcomp_simp', match_lcomp_parallel, lcomp, uses_verts=True)

def lcomp_threaded(g):
    simp_threaded(g, 'lcomp_simp', match_lcomp_parallel, lcomp, uses_verts=True,skip_unthreaded_pass=True)
    print("Full pass: ",end='')
    nthreads = 5
    pool = mp.Pool(processes=nthreads)
    i = 0
    new_matches = True
    while new_matches:
        i += 1
        new_matches = False
        matches = match_lcomp_parallel(g)
        if len(matches) > 0:
            print(len(matches), end='')
            vs, ns = [], []
            for v, neighbours in matches:
                a = g.phase(v)
                for v2 in neighbours: g.add_to_phase(v2, -a)
                vs.append(v)
                ns.append(neighbours)
            for etab in pool.map(_lcomp_do, (ns[i:i + 10] for i in range(0, len(ns), 10))):
                g.add_edge_table(etab)
            g.remove_vertices(vs)
            print('. ', end='')
            new_matches = True
    pool.close()
    print('\nfinished in ' + str(i) + ' iterations')

def _lcomp_do(matches):
    etab = dict()
    for neighbours in matches:
        for i in range(len(neighbours)):
            for j in range(i+1, len(neighbours)):
                e = (neighbours[i],neighbours[j])
                if (e[0] > e[1]): e = (e[1],e[0])
                if e not in etab: etab[e] = [0,1]
                else: etab[e][1] += 1

    return etab

def bialg_threaded(g):
    return simp_threaded(g, 'bialg_simp', match_bialg_parallel, bialg, uses_verts=False)

def spider_threaded(g):
    return simp_threaded(g, 'spider_simp', match_spider_parallel, spider, uses_verts=False)

def id_threaded(g):
    return simp_threaded(g, 'id_simp', match_ids_parallel, remove_ids, uses_verts=True)

def clifford_threaded(g):
    spider_threaded(g)
    to_gh(g)
    lcomp_threaded(g)
    pivot_threaded(g)
    to_rg(g)
    id_threaded(g)


