$(document).on('page:change', function () {
  function getPassengers () {
    return $('.nested-fields').length
  }

  function getPrice () {
    return parseFloat($('#ze_price').data('price').replace(/\$/, ''))
  }

  function setPrice () {
    var thePrice = getPassengers() * getPrice()
    $('.fare').html('$' + thePrice)
    $('#fare-price').val(thePrice)
  }

  $('#new_booking').on('cocoon:after-insert', function () {
    $('.pass_number').html(parseInt($('.pass_number').html()) + 1)
    setPrice()
  })

  $('#new_booking').on('cocoon:after-remove', function() {
    $('.pass_number').html(parseInt($('.pass_number').html()) - 1)
    setPrice()
  })

  setPrice()
})
