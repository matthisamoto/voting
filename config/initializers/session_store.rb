# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_voting_session',
  :secret      => 'a68b2b3fe190ad9c3e57c396e640e33eb727f2e1bc3f65f01ba414950679832c5de853fcb81bb9804ba5b71e9934747af57f485ef44da3dd5b2c36ead0e9d957'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
