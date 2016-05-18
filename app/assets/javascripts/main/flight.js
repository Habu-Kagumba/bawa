$(document).on('page:change', function () {
  $('#search-flights').validate({
    rules: {
      'passengers': {
        required: true
      }
    },
    messages: {
      'passengers': {
        required: 'How many passengers?'
      }
    }
  })

  var airports = new Bloodhound({
    datumTokenizer: function(datum) {
      return Bloodhound.tokenizers.whitespace(datum.location)
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/airports/?q=%QUERY',
      wildcard: '%QUERY',
      filter: function(airports) {
        return $.map(airports.results, function(port) {
          return {
            id: port.id,
            name: port.name,
            location: port.location
          }
        })
      }
    }
  })

  airports.initialize()

  $('.location_airport .typeahead').typeahead({
    highlight: true
  }, {
    name: 'airports',
    displayKey: 'name',
    source: airports.ttAdapter(),
    templates: {
      suggestion: function(data) {
        return '<p>' + data.name + ' <span>' + data.location + '</span></p>'
      }
    }
  }).on(['typeahead:selected', 'typeahead:autocompleted'].join(' '), function(obj, datum) {
    $('#location').val(datum.id)
  }).on('keyup', function () {
    if($('.tt-suggestion').length === 0){
      $('#location').val('')
    }
  })

  $('.destination_airport .typeahead').typeahead({
    highlight: true
  }, {
    name: 'airports',
    displayKey: 'name',
    source: airports.ttAdapter(),
    templates: {
      suggestion: function(data) {
        return '<p>' + data.name + ' <span>' + data.location + '</span></p>'
      }
    }
  }).on(['typeahead:selected', 'typeahead:autocompleted'].join(' '), function(obj, datum) {
    $('#destination').val(datum.id)
  }).on('keyup', function () {
    if($('.tt-suggestion').length === 0){
      $('#destination').val('')
    }
  })

  $('#ddate').datetimepicker({
    timepicker: false,
    format: 'd/m/Y',
    minDate: 0
  })

  $('#search-flights').on('ajax:success', function(event, data, status, xhr) {
    $('#search-results').html(data)

    $('.single-flight')
    .addClass('animated fadeInUp')
    .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
      $(this).removeClass('animated fadeInUp')
    })

  })
})
