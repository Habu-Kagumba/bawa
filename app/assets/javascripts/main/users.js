$(document).on('page:change', function () {
  $('.user-forms').validate({
    rules: {
      'user[first_name]': {
        required: true,
        lettersonly: true,
        rangelength: [3, 25]
      },
      'user[last_name]': {
        required: true,
        lettersonly: true,
        rangelength: [3, 25]
      },
      'user[username]': {
        remote: {
          url: '/users/check_username',
          type: 'post'
        },
        rangelength: [3, 60]
      },
      'user[email]': {
        required: true,
        remote: {
          url: '/users/check_email',
          type: 'post'
        },
        email: true
      },
      'user[password]': {
        required: true,
        rangelength: [8, 20]
      },
      'user[password_confirmation]': {
        required: true,
        equalTo: '#user_password'
      }
    },
    messages: {
      'user[first_name]': {
        required: 'First name can\'t be blank',
        lettersonly: 'First name has to contain only letters',
        rangelength: 'First name length has to be between 3 and 25 characters'
      },
      'user[last_name]': {
        required: 'Last name can\'t be blank',
        lettersonly: 'Last name has to contain only letters',
        rangelength: 'Last name length has to be between 3 and 25 characters'
      },
      'user[username]': {
        required: 'Username can\'t be blank',
        remote: 'Username already in use. Please choose another',
        rangelength: 'Username length has to be between 3 and 25 characters'
      },
      'user[email]': {
        remote: 'Email address already in use. Please choose another',
        required: 'Email can\'t be blank',
        email: 'Please enter a valid email adress'
      },
      'user[password]': {
        required: 'Password can\'t be blank',
        rangelength: 'Password length has to be between 8 and 20'
      },
      'user[password_confirmation]': {
        required: 'Password confirmation can\'t be blank',
        equalTo: 'Has to match with the password'
      }
    }
  })
})
