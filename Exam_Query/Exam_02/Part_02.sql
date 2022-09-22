select  pv.Id [PVID],
		pv.Name [Product]


from ProductVariant pv
Where pv.Published = 1
and pv.Deleted = 0
and pv.ShelfType in (5,9)
