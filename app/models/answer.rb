class Answer < ActiveRecord::Base
  belongs_to :question
  has_one :challenge
  
  def answerd_text
    if self.is_answer
      return self.question.answer
    else
      return self.question.alterntive
    end
  end
  
  def not_answered_text
    if self.is_answer
      return self.question.alterntive
    else
      return self.question.answer
    end
  end
  
  def after_save
    message = "#{self.name} prefers #{self.answerd_text} over #{self.not_answered_text}"
    tc = TwitterClient.new 
    tc.post_status(message)
  end
  
  #def validate
     #if self.challenge.answer
     #errors.add_to_base "Challange question failed." if !attachment.blank? and attachment_label.blank?
  #end

end