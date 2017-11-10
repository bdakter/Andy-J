# Speak about NULL and DEFAULT values.

On the surface, the names of each speak for themselves. NULL is an *unknown* values and DEFAULT is used to assign data in a row to the specified value when no data from the user is given.

**NULL**
However, we must be careful with NULLs. Because they are technically unknown values, their behavior is different situations is also unknown. If there is a NULL value in a column and the rows are sorted by that column, the rows with NULL will appear at the top (in PostgreSQL). In other RDBMSs, NULLs may appear last.

If calculations are performed on NULLs, such as totaling a column or multiple by a price, the resulting value with also be NULL since any operation with a NULL is also NULL. If this calculation was something like the amount of money based on a NULL value, then the amount will be NULL. What does a payroll system do with a NULL amount of money? Well, probably nothing since it likely has safeguards for this, but if not, it may try to transfer and undefined amount of money.

**DEFAULT**

The solution: avoid having NULL values in your database unless absolutely necessary. Instead, create a DEFAULT value on that column. In the example where pay is calculated based on hours worked, the default value for hours worked should logically be zero. Therefore further calculations will make sense instead of returning more NULL values.