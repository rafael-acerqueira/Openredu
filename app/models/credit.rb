class Credit < ActiveRecord::Base
  belongs_to :user
  
  
   acts_as_state_machine :initial => :pending
    state :pending
    state :error
    state :approved
    state :disapproved
  
   event :approve do
      transitions :from => :pending, :to => :approved
   end
   
   event :disapprove do
      transitions :from => :pending, :to => :disapproved
   end

   event :failure do
      transitions :from => :pending, :to => :error # TODO salvar estado de "erro" no bd
   end
  
   def self.total(user_id)
    self.connection.execute("select sum(value) from credits where user_id = #{user_id}").fetch_row
   end
  
  
  
end
