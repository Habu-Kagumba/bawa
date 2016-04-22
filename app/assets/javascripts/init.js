window.Bawa || (window.Bawa = {})

Bawa.init = () => console.log('Bawa is taking off...✈️ ')

$(document).on('page:change', () => Bawa.init())
