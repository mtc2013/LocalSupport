module MapMarkerJson
  class Marker < Hash
    def initialize

    end
    def lat latitude

    end
    def lng longitude

    end
    def infowindow string

    end
    def json hash

    end
  end
  def self.build(organisations)
    marker = Marker.new
    organisations.map{|org| [org, marker]}.each do |org, marker|
      yield org, marker
    end
    [1].to_json
  end
end
