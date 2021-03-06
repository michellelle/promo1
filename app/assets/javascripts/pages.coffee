# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#chevron in footer action

$(document).ready ->
  # Initialize Tooltip
  $('[data-toggle="tooltip"]').tooltip()
  return
  
### Set rates + misc ###

taxRate = 0.05
shippingRate = 15.00
fadeTime = 300

### Assign actions ###

### Recalculate cart ###

recalculateCart = ->
  subtotal = 0

  ### Sum up row totals ###

  $('.product').each ->
    subtotal += parseFloat($(this).children('.product-line-price').text())
    return

  ### Calculate totals ###

  tax = subtotal * taxRate
  shipping = if subtotal > 0 then shippingRate else 0
  total = subtotal + tax + shipping

  ### Update totals display ###

  $('.totals-value').fadeOut fadeTime, ->
    $('#cart-subtotal').html subtotal.toFixed(2)
    $('#cart-tax').html tax.toFixed(2)
    $('#cart-shipping').html shipping.toFixed(2)
    $('#cart-total').html total.toFixed(2)
    if total == 0
      $('.checkout').fadeOut fadeTime
    else
      $('.checkout').fadeIn fadeTime
    $('.totals-value').fadeIn fadeTime
    return
  return

### Update quantity ###

updateQuantity = (quantityInput) ->

  ### Calculate line price ###

  productRow = $(quantityInput).parent().parent()
  price = parseFloat(productRow.children('.product-price').text())
  quantity = $(quantityInput).val()
  linePrice = price * quantity

  ### Update line price display and recalc cart totals ###

  productRow.children('.product-line-price').each ->
    $(this).fadeOut fadeTime, ->
      $(this).text linePrice.toFixed(2)
      recalculateCart()
      $(this).fadeIn fadeTime
      return
    return
  return

### Remove item from cart ###

removeItem = (removeButton) ->

  ### Remove row from DOM and recalc cart total ###

  productRow = $(removeButton).parent().parent()
  productRow.slideUp fadeTime, ->
    productRow.remove()
    recalculateCart()
    return
  return

$('.product-quantity input').change ->
  updateQuantity this
  return
$('.product-removal button').click ->
  removeItem this
  return

# ---
# generated by js2coffee 2.2.0