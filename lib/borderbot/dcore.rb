# Welcome to Dcore( Data Sorting Core )
# Here is where all data is sorted.
require "borderbot/hash"

class Dcore

  def zortificate_ports(bwtXML)
      #bwtXML converted to hash for easy usage
      bwtHASH = Hash.from_xml(bwtXML.to_s)
      #ports array
      ports = []

      for port in bwtHASH[:border_wait_time][:port]
        crossingName, portName, updateTime, portNumber, portStatus, data = parsePortData(port)
        zortificatedPort = {
          updateTime: updateTime,
          portNumber: portNumber,
          portStatus: portStatus,
          portName: portName,
          crossingName: crossingName,
          data: data
        }
        ports.push(zortificatedPort)
      end
      return ports
  end

  def get_wait_times_on_day_and_time(bwtJSON, day_of_the_week, time_slot)
    grouped_by_day_of_the_week = bwtJSON["wait_times"].group_by{|dataset| dataset["bwt_day"]}
    day_wait_times = grouped_by_day_of_the_week.fetch(day_of_the_week)
    wait_times_in_specific_time = day_wait_times.select {|data| data["time_slot"] == time_slot}

    return wait_times_in_specific_time_and_day
  end

  def parsePortData(port)
      #Get Update time
      updateTime = getUpdateTime(port)
    if !updateTime.nil?
        #Get Data values
        data = getPortData(port)
        #Get Port status value
        portStatus = port[:port_status]
        #Get Port number
        portNumber = port[:port_number]
        #get port name
        portName = port[:port_name]
        #get port name
        crossingName = port[:crossing_name]
        #Return to DataPort()
        return [crossingName, portName, updateTime, portNumber, portStatus, data]
    else
        return nil
    end
  end

  def getUpdateTime(port)
    dateStr = port[:date]

    #check all options
    updateTimesArray = []
    if port[:commercial_vehicle_lanes][:standard_lanes][:update_time] != nil then updateTimesArray.push(port[:commercial_vehicle_lanes][:standard_lanes][:update_time]) end
    if port[:commercial_vehicle_lanes][:FAST_lanes][:update_time] != nil then updateTimesArray.push(port[:commercial_vehicle_lanes][:FAST_lanes][:update_time]) end
    if port[:passenger_vehicle_lanes][:NEXUS_SENTRI_lanes][:update_time] != nil then updateTimesArray.push(port[:passenger_vehicle_lanes][:NEXUS_SENTRI_lanes][:update_time]) end
    if port[:passenger_vehicle_lanes][:ready_lanes][:update_time] != nil then updateTimesArray.push(port[:passenger_vehicle_lanes][:ready_lanes][:update_time]) end
    if port[:passenger_vehicle_lanes][:standard_lanes][:update_time] != nil then updateTimesArray.push(port[:passenger_vehicle_lanes][:standard_lanes][:update_time]) end
    if port[:pedestrian_lanes][:ready_lanes][:update_time] != nil then updateTimesArray.push(port[:pedestrian_lanes][:ready_lanes][:update_time]) end
    if port[:pedestrian_lanes][:standard_lanes][:update_time] != nil then updateTimesArray.push(port[:pedestrian_lanes][:standard_lanes][:update_time]) end

    if updateTimesArray.size > 0 && updateTimesArray.uniq.size == 1 && updateTimesArray[0].class == String
      timeStr = updateTimesArray[0]
      timeStr = timeStr.gsub('Noon', '12:00 pm')
      timeStr = timeStr.gsub('Midnight', '12:00 am')
      timeStr = timeStr.gsub(' 0:', ' 12:')
      timeCleaned = timeStr.slice(3, timeStr.length)
      response =  DateTime.strptime(dateStr + ' ' + timeCleaned, '%m/%d/%Y %I:%M %p %Z')
    else
      response = nil
    end
    return response
  end

  def getLaneData(lane)
    laneData = {}
    case lane[:operational_status]
      when 'N/A'
        laneData[:operational_status] = 'N/A'

      when 'Lanes Closed'
        laneData[:operational_status] = 'Lanes Closed'

      when 'no delay'
        laneData[:operational_status] = 'no delay'
        laneData[:lanes_open] = lane[:lanes_open].to_i
        laneData[:delay_minutes] = lane[:delay_minutes].to_i

      when 'delay'
        laneData[:operational_status] = 'delay'
        laneData[:lanes_open] = lane[:lanes_open].to_i
        laneData[:delay_minutes] = lane[:delay_minutes].to_i

    else
      laneData = nil
    end

    return laneData
  end

  def isAvailable(lane)
    isAvailable = false
    if lane[:operational_status] != 'N/A'
      isAvailable = true
    end
    return isAvailable
  end

  def getPortData(port)
    # Get Details values
    laneData = {
      commercial: {},
      passenger: {},
      pedestrian: {}
    }

    #Get Commercial Lanes
    commercialStandardLanes = getLaneData(port[:commercial_vehicle_lanes][:standard_lanes])
    if isAvailable(commercialStandardLanes) then laneData[:commercial].merge!(standard_lanes: commercialStandardLanes) end
    commercialFastLanes = getLaneData(port[:commercial_vehicle_lanes][:FAST_lanes])
    if isAvailable(commercialFastLanes) then laneData[:commercial].merge!(FAST_lanes:  commercialFastLanes) end
    #Delete commercial key if is empty
    if laneData[:commercial].empty? then laneData.delete(:commercial) end

    #Get Passenger Lanes
    passengerNexusSentriLanes = getLaneData(port[:passenger_vehicle_lanes][:NEXUS_SENTRI_lanes])
    if isAvailable(passengerNexusSentriLanes) then laneData[:passenger].merge!(NEXUS_SENTRI_lanes:   passengerNexusSentriLanes) end
    passengerReadyLanes = getLaneData(port[:passenger_vehicle_lanes][:ready_lanes])
    if isAvailable(passengerReadyLanes) then laneData[:passenger].merge!(ready_lanes:  passengerReadyLanes) end
    passengerStandardLanes  = getLaneData(port[:passenger_vehicle_lanes][:standard_lanes])
    if isAvailable(passengerStandardLanes) then laneData[:passenger].merge!(standard_lanes: passengerStandardLanes) end
    #Delete commercial key if is empty
    if laneData[:passenger].empty? then laneData.delete(:passenger) end

    #Get Pedestrian Lanes
    pedestrianReadyLanes = getLaneData(port[:pedestrian_lanes][:ready_lanes])
    if isAvailable(pedestrianReadyLanes) then laneData[:pedestrian].merge!( ready_lanes:  pedestrianReadyLanes ) end
    pedestrianStandardLanes = getLaneData(port[:pedestrian_lanes][:standard_lanes])
    if isAvailable(pedestrianStandardLanes) then laneData[:pedestrian].merge!( standard_lanes: pedestrianStandardLanes ) end
    #Delete commercial key if is empty
    if laneData[:pedestrian].empty? then laneData.delete(:pedestrian) end

    constructionNotice = port[:construction_notice]
    if constructionNotice != nil && constructionNotice.empty? == false
      laneData[:construction_notice] = constructionNotice
    end

    return laneData
  end
end
