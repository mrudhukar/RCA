class RootCause < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  index_name BONSAI_INDEX_NAME
  
  belongs_to :team

  has_many :root_cause_bugs, :dependent => :destroy
  has_many :bugs, :through => :root_cause_bugs

  has_many :followups, :dependent => :destroy

  validates :title, :presence => true

  mapping do
    indexes :id, :type => 'integer', :index => :not_analyzed
    indexes :title, :type => 'string', :analyzer => "snowball"
    indexes :description, :type => 'string', :analyzer => "snowball"
  end

  def self.suggestions(query, list_of_rc_to_include)
    begin
      search_options = {:page => 1, :per_page => 8, :load => true}

      r = tire.search search_options do
        unless query.blank?
          query do
              string "#{query}*", :default_operator => 'OR', :analyze_wildcard => true
          end

          filter :terms, :id => list_of_rc_to_include || []
        end
      end

      return r
    rescue Exception => ex
      raise ex if Rails.env == 'development'
      Airbrake.notify(ex)
      response = {
        'hits'  => {'hits' => [], 'total' => 0},
        'took'  => 1
      }
      return Tire::Results::Collection.new(response, {}) # We should show empty results when the search deamon is down.
    end
  end

end
