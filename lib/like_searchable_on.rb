require File.dirname(__FILE__) + '/like_searchable_on/searchable'

ActiveRecord::Base.send( :include, LikeSearchableOn::Searchable )