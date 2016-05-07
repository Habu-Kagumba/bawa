window.Bawa || (window.Bawa = {})

Bawa.init = function() {
  console.log('Bawa is taking off...')
  $(document).ajaxStart(function(){
    $('#loading').show()
  }).ajaxStop(function(){
    $('#loading').hide()
  })
}

$(document).on('page:change', function () {
  Bawa.init()
})
