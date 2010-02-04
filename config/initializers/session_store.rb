# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_feysbook_session',
  :secret      => 'ce1722b5b92c15dace6cd4c15a7881dbac794962560aca8b9ce34ec8129b70aafd40cfa0ff221d21ecee8b10fce70102ab7bb4b555161a70b71e1ff7e68b6662'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
