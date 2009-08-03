class Question < ActiveRecord::Base
  has_many :answers
  validates_presence_of :answer, :alterntive, :user
  belongs_to :user
  
  def before_save
    [self.answer, self.alterntive].each { |s| s.strip! }
  end
  
  def after_save
    message = "Would u prefer #{self.answer} or #{self.alterntive} asks #{self.user.login}"
    tc = TwitterClient.new 
    tc.post_status(message)
  end
  
  def self.per_page
    5
  end
  
  
end
