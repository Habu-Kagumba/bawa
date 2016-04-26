window.Bawa || (window.Bawa = {})

Bawa.init = function() {
  console.log('Bawa is taking off...')
}

$(document).on('page:change', function () {
  Bawa.init()
})
