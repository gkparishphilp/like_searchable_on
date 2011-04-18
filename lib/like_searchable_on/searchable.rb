module LikeSearchableOn #:nodoc:
	module Searchable

		def self.included( base )
			base.extend ClassMethods
		end

		module ClassMethods
			
			def like_searchable_on( cols=[] )
				# build a where_clause
				where_clause = String.new
				if cols.empty?
					raise "Must set field to search in like_searchable_on declaration"
				else
					for col in cols do
						col == cols.last ? ( where_clause += "#{col} like :term " ) : ( where_clause += "#{col} like :term or " )
					end
				end
						
				self.class_eval <<-END
					def self.like_search_for( term )
						if term.present?
							term = "%" + term.to_s + "%"
							where( "#{where_clause}", :term => term )
						else
							return scoped
						end
					end
				END
			end
			
		end
	end
end