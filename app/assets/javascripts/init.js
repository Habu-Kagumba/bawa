window.Bawa || (window.Bawa = {})

Bawa.init = function() {
  $(document).ajaxStart(function(){
    $('#loading').show()
  }).ajaxStop(function(){
    $('#loading').hide()
  })
}

$(document).on('page:change', function () {
  Bawa.init()
})
