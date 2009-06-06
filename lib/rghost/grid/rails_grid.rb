require 'rghost/ps_object'
#
# Grid::Rails mapps grid columns to ActiveRecord attributes. For
# example, let's take a Calls class to represent telephone calls.
#
# ===Example
#   rails_grid=Grid::Rails.new(:align => :center, :width => 3)
#
# Mapping, first the attribute name then the already known optionsName
#  rails_grid.column :mobile,   :title => "Mobile", :align => :right
#  rails_grid.column :duration, :title => "Duration",:width => 3
#  rails_grid.column :start,    :title => "Start", :format => :eurodate
#  rails_grid.column :called,   :title => "Number", :align => :right, :title_align => :center
# Load data
#   calls = Call.find(:all, :limit => 5000)
#   rails_grid.data(calls)
# ====Relationships
# You can also use attributes of associated objects, via a block or
# string. For example consider Accounts and Customers
# relationship. Let's produce a grid od all Customers plus some data
# reffering to the first account the customer had created.
#
#   class Accounts < ActiveRecord::Base
#     belongs_to :customer
#   end
#   class Customers < ActiveRecord::Base
#     has_many :accounts
#   end
#
#   c = Customers.find(:all, :include => :accounts )
#
# Using a block
#   g=Grid::Rails.new  :width => 4
#   g.column :id,         :title => "Customer id"
#   g.column :name,       :title => "Name",   :width => 6
#   g.column :created_on, :title => "Date ",  :format => lambda{|d| d.strftime("%m/%d/%Y") }
#   g.column lambda { accounts.first.login }, :title => "Login"
#   g.column lambda { accounts.first.type },  :title => "Account Type"
#   g.data(c)
# Or a String
#   g.column 'accounts.first.login', :title => Login"
class RGhost::Grid::Rails < RGhost::Grid::Base
  #The parameter +_data+ is an Array of ActiveRecord::Base objects.
  def data(_data)
    _data.collect do |d|
      line=@rails_cols.collect do |c|
        case c[:field_name]
          when Symbol
            d[c[:field_name]]
          when String
            d.instance_eval c[:field_name]
          when Proc
            d.instance_eval(&c[:field_name])
        end
      end
      proc_line(line)
    end
  end

  def col(field_name, options={}) #:nodoc:
    super(options[:title],options)
     
    @rails_cols||=[]
    owf=options.dup #from options with field
    owf[:field_name]||=field_name
    @rails_cols << owf

  end

  def column(field_name, options={}) #:nodoc:
    col(field_name,options)
  end

end
