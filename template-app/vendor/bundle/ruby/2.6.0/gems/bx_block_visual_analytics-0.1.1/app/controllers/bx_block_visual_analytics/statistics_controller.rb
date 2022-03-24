module BxBlockVisualAnalytics
  class StatisticsController < BxBlockVisualAnalytics::ApplicationController
    def users
      @full_data = if params[:dates] == 'week'
        {
          data: {
            labels: %w[1 2 3 4 5 6 7 8],
            data: [
                [AccountBlock::Account.where('created_at > ?', DateTime.now - 1.week).count],
                [get_week_count(2)],
                [get_week_count(3)],
                [get_week_count(4)],
                [get_week_count(5)],
                [get_week_count(6)],
                [get_week_count(7)],
                [get_week_count(8)]
            ],
            barColors: ['#7db6b0']
          }
        }
      elsif params[:dates] == 'month'
        labels =  [
                    Date::MONTHNAMES[DateTime.now.month][0..2],
                    Date::MONTHNAMES[(DateTime.now - 1.month).month][0..2],
                    Date::MONTHNAMES[(DateTime.now - 2.month).month][0..2],
                    Date::MONTHNAMES[(DateTime.now - 3.month).month][0..2],
                    Date::MONTHNAMES[(DateTime.now - 4.month).month][0..2],
                    Date::MONTHNAMES[(DateTime.now - 5.month).month][0..2],
                    Date::MONTHNAMES[(DateTime.now - 6.month).month][0..2],
                    Date::MONTHNAMES[(DateTime.now - 7.month).month][0..2],
                    Date::MONTHNAMES[(DateTime.now - 8.month).month][0..2],
                    Date::MONTHNAMES[(DateTime.now - 9.month).month][0..2],
                    Date::MONTHNAMES[(DateTime.now - 10.month).month][0..2],
                    Date::MONTHNAMES[(DateTime.now - 11.month).month][0..2],
                    Date::MONTHNAMES[(DateTime.now - 12.month).month][0..2],
                    Date::MONTHNAMES[(DateTime.now - 13.month).month][0..2],
                  ]
        {
          data: {
            labels: labels,
            data: [
                [AccountBlock::Account.where('created_at > ?', DateTime.now.beginning_of_month).count],
                [AccountBlock::Account.where('created_at > ?', (DateTime.now - 1.month).beginning_of_month).where('created_at < ?', DateTime.now.beginning_of_month).count],
                [get_month_count(2)],
                [get_month_count(3)],
                [get_month_count(4)],
                [get_month_count(5)],
                [get_month_count(6)],
                [get_month_count(7)],
                [get_month_count(8)],
                [get_month_count(9)],
                [get_month_count(10)],
                [get_month_count(11)],
                [get_month_count(12)],

            ],
            barColors: ['#7db6b0']
          }
        }
      else
        {
          data: {
            labels: [
                      Date.today.to_datetime.strftime('%A')[0..2],
                      Date.yesterday.to_datetime.strftime('%A')[0..2],
                      (Date.today - 2.day).to_datetime.strftime('%A')[0..2],
                      (Date.today - 3.day).to_datetime.strftime('%A')[0..2],
                      (Date.today - 4.day).to_datetime.strftime('%A')[0..2],
                      (Date.today - 5.day).to_datetime.strftime('%A')[0..2],
                      (Date.today - 6.day).to_datetime.strftime('%A')[0..2],
                      (Date.today - 7.day).to_datetime.strftime('%A')[0..2],
                      (Date.today - 8.day).to_datetime.strftime('%A')[0..2],

                    ],
            data: [
                [AccountBlock::Account.where('created_at > ?', Date.today.to_datetime).count],
                [AccountBlock::Account.where('created_at > ?', Date.yesterday.to_datetime).where('created_at < ?', Date.today.to_datetime).count],
                [AccountBlock::Account.where('created_at > ?', (Date.today - 2.day).to_datetime).where('created_at < ?', Date.yesterday.to_datetime).count],
                [get_date_count(3)],
                [get_date_count(4)],
                [get_date_count(5)],
                [get_date_count(6)],
                [get_date_count(7)],
                [get_date_count(8)]
            ],
            barColors: ['#7db6b0']
          }
        }
      end
      render json: @full_data, status: :ok
    end

    private

    def get_week_count(week_no)
      start_week = DateTime.now - week_no.week
      end_week = DateTime.now - (week_no - 1).week
      AccountBlock::Account.where('created_at > ?', start_week).where('created_at < ?', end_week).count
    end

    def get_month_count(month_no)
      start_month = (DateTime.now - month_no.month).beginning_of_month
      end_month = (DateTime.now - (month_no - 1).month).beginning_of_month
      AccountBlock::Account.where('created_at > ?', start_month).where('created_at < ?', end_month).count
    end

    def get_date_count(date_no)
      start_date = (Date.today - date_no.day).to_datetime
      end_date = (Date.today - (date_no - 1).day).to_datetime
      AccountBlock::Account.where('created_at > ?', start_date).where('created_at < ?', end_date).count
    end
  end
end
