-- https://www.hackerrank.com/challenges/binary-search-tree-1/problem
/*
You are given a table, BST, containing two columns:
N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
Write a query to find the node type of Binary Tree ordered by the value of the node.
Output one of the following for each node:
Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.
*/

select n,
    CASE
        WHEN p is null THEN 'Root'
        WHEN 0 = (select count(*) from bst as sub where sub.p = bst.n)
            THEN 'Leaf'
        ELSE 'Inner'
    END
from bst
order by n;