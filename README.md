# alphanum_comparator

Porting of "The Alphanum Algorithm" in Dart.

# The Problem
Look at most sorted list of filenames, product names, or any other text that contains alphanumeric characters - both letters and numbers. Traditional sorting algorithms use ASCII comparisons to sort these items, which means the end-user sees an unfortunately ordered list that does not consider the numeric values within the strings.

For example, in a sorted list of files, "z100.html" is sorted before "z2.html". But obviously, 2 comes before 100!

Sorting algorithms should sort alphanumeric strings in the order that users would expect, especially as software becomes increasingly used by nontechnical people. Besides, it's the 21st Century; software engineers can do better than this.

# The Solution
I created the Alphanum Algorithm to solve this problem. The Alphanum Algorithm sorts strings containing a mix of letters and numbers. Given strings of mixed characters and numbers, it sorts the numbers in value order, while sorting the non-numbers in ASCII order. The end result is a natural sorting order.

Here's a list of sample filenames to illustrate the difference between sorting with the Alphanum algorithm and traditional ASCII sort. On the left is what you live with on a daily basis. On the right is what you could have, if more developers were motivated to sort lists as people would expect. Which list makes more sense to you? Which would be more comfortable to you as you're using an application?

Traditional	 	
z1.doc
z10.doc
z100.doc
z101.doc
z102.doc
z11.doc
z12.doc
z13.doc
z14.doc
z15.doc
z16.doc
z17.doc
z18.doc
z19.doc
z2.doc
z20.doc
z3.doc
z4.doc
z5.doc
z6.doc
z7.doc
z8.doc
z9.doc
        
Alphanum
z1.doc
z2.doc
z3.doc
z4.doc
z5.doc
z6.doc
z7.doc
z8.doc
z9.doc
z10.doc
z11.doc
z12.doc
z13.doc
z14.doc
z15.doc
z16.doc
z17.doc
z18.doc
z19.doc
z20.doc
z100.doc
z101.doc
z102.doc
        
See http://www.davekoelle.com/alphanum.html for details
