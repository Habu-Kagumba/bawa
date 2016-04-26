$(document).on('page:change', function () {
  $('#session_form > form').validate({
    rules: {
      'session[email_username]': {
        required: true,
        remote: {
          url: '/sessions/check_username_email',
          type: 'post'
        }
      },
      'session[password]': {
        required: true
      }
    },
    messages: {
      'session[email_username]': {
        required: 'Please enter your username or email address',
        remote: 'Username or email address not found'
      },
      'session[password]': {
        required: 'Please enter your password'
      }
    }
  })
})
