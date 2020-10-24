//Encrypt bcrypt js:
const bcrypt = require("bcrypt")

const password = "password"
const saltRounds = 10

bcrypt.genSalt(saltRounds, function (err, salt) {
  if (err) {
    throw err
  } else {
    bcrypt.hash(password, salt, function(err, hash) {
      if (err) {
        throw err
      } else {
        console.log(hash)
      }
    })
  }
})
