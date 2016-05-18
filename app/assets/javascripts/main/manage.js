$(document).on('page:change', function () {
  $('#manage-check').on('change', function() {
    if ($(this).is(':checked')) {
      $('body').addClass('modal-open')
    } else {
      $('body').removeClass('modal-open')
    }
  })

  $('.modal-fade-screen, .modal-close').on('click', function() {
    $('.modal-state:checked').prop('checked', false).change()
  })

  $('.modal-inner').on('click', function(e) {
    e.stopPropagation()
  })

  $('#manage-bookings-form').on('ajax:success', function(event, data, status, xhr) {
    if (!data) {
      $('span.manage-error')
      .show()
      .text('No booking was found!')
    } else {
      $('span.manage_error').hide()
      location.assign(
        window.location.origin + '/bookings/' + data.slug
      )
    }
  })

  function getNoPassengers () {
    return $('.nested-fields').length
  }

  function getBookingPrice () {
    return parseFloat($('#ze_booking_price').attr('data-price').replace(/\$/, ''))
  }

  function setZeBookingPrice (price) {
    $('#ze_booking_price').attr('data-price', price)
  }

  function setBookingPrice () {
    var thePrice = (getNoPassengers() * getBookingPrice()).toFixed(2)
    $('#booking-price').html('$' + thePrice)
    $('#fare-price').val(thePrice)
  }

  function setFlight (res) {
    $('#flight-id').val(res.results[0].id)
  }

  $('#edit-booking').on('cocoon:after-insert', function () {
    setBookingPrice()
  })

  $('#edit-booking').on('cocoon:after-remove', function () {
    setBookingPrice()
  })

  $('#booking_location_name, #booking_destination_name, .booking_ddate').blur(function () {
    fetch('/search_flight.json?when=' + $('.booking_ddate').val() + '&location=' + $('#location').val() + '&destination=' + $('#destination').val(), {
      method: 'get'
    }).then(function (response) {
      return response.text()
    }).then(function (text) {
      var res = JSON.parse(text)

      if (res.count === 0) {
        $('span.booking-error')
        .text('No booking was found!')
        .css({ opacity: 1 })
      } else if (res.count === 1) {
        setFlight(res)
        setZeBookingPrice(res.results[0].price)
        setBookingPrice()
        $('.airline span').text(res.results[0].airline)
        $('.airline small').text(res.results[0].fnumber)
        $('span.booking-error')
        .css({ opacity: 0 })
      } else if (res.count > 1) {
        $('span.booking-info')
        .html('More than one match! <a href="#">See all matches</a>')
      }
    })
  })
})
