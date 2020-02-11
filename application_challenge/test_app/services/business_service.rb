require './test_app/models/visit.rb'
require './test_app/models/pageview.rb'

class BusinessService

  def logic
    res = HttpService.new.fetch_sample_response
    res.each do |res|
      visit = Visit.new(evid: res['referrerName'], vendor_site_id: res['idSite'],
                        vendor_visit_id: res['idVisit'], visit_ip: res['visitIp'],
                        vendor_visitor_id: res['visitorId'])
      position = 0
      if visit.save
        position = position + 1
        pageview_details = res['actionDetails'].sort_by { |hsh| hsh[:timestamp] }
        pageview_details.each do |action_detail|
          pageview = visit.page_views.create(visit_id: visit.id, url: action_detail['url'],
                                             title: action_detail['pageTitle'], time_spent: action_detail['timeSpent'],
                                             timestamp: action_detail['timestamp'], position: position)
        end
      end
    end
  end
end
