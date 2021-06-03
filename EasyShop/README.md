#  EASYSHOP

FIX: 
1- No placeholder created when new product is created - ok

2 - Too many characters for shop / product name. Test with dummy data on devices first
Shop: 
iphone 6s -> 56 / 60
iphone 11 -> 60 + / 60 +
Item: 
iphone 6s -> 42 / 46
iphone 11 -> 48 / 51

NEEDS A TEST

3 - When introducing an amount and not saving it by clicking the enter the amount dissapear if the product is selected - ok

4 - .. continues from 3, if the product is already selected and the user types and amount it doesn’t get saved when leaving the screen. - ok

5 - new products create, new amount added it disappears when selecting the product. - ok

6 - Being on SelectedItemView with items selected, then navigate to itemList and deselect this products, when going back to Cart tab it appears the empty SelectedItemView with “unknown item name” visible. - Not happening anymore

7- SelectedItemView changes the view when navigating back and forth. Google it!

8- When deleting a shop/product that has been selected, the red point remains visible on cart. - Fixed with notification center

9- Save newShop && newItem when pressing enter
