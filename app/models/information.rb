class Information < ActiveRecord::Base
  belongs_to :user
  has_many :tickets
  validates :title, length: { maximum: 50 }, presence: true
  validates :content, length: { maximum: 2000 }, presence: true
  validates :start_date, presence: true
  validates :expire_date, presence: true
  validate :expire_date_should_be_before_start_date

  private

  def expire_date_should_be_before_start_date
    return unless start_date && expire_date
    if expire_date >= start_date || expire_date <= Time.now
      errors.add(:start_date ,'について掲載期限は開催日時より前で、現在より後の日時を設定してください')
    end
  end
end
