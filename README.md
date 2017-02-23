[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/burguer80/borderbot.svg?branch=master)](https://travis-ci.org/burguer80/borderbot)


<!-- [![Coverage Status](https://coveralls.io/repos/github/burguer80/borderbot/badge.svg?branch=master)](https://coveralls.io/github/burguer80/borderbot?branch=master) -->

# Borderbot

Borderbot is a easy way to get the border wait times from
[U.S. Customs and Border Protection Border Wait Times](https://bwt.cbp.gov).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'borderbot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install borderbot

## Usage
Tell Borderbot do his job.
```ruby
agent = Borderbot.go #To fetch, parse, sort and optimize the data.
```

Access Borderbot Agent data.
```ruby
agent.ports       # Array with ports data
agent.bwt_url     # XML url from Border Wait Times
agent.executed_at # Date and time from the execution time
```
Ports array skeleton
```ruby
agent.ports.class                                       #=> Array
agent.ports[0].keys                                     #=> [:updateTime, :portNumber, :portStatus, :portName, :crossingName, :data]
agent.ports[0][:updateTime].strftime("%A %b %d %H:%M")  #=> "Wednesday Feb 22 17:00"
agent.ports[0][:portNumber]                             #=> "250301"
agent.ports[0][:portStatus]                             #=> "Open"
agent.ports[0][:portName]                               #=> "Calexico"
agent.ports[0][:crossingName]                           #=> "East"
```


Ports array skeleton
```ruby
agent.ports[0][:data]
##  This is the data skeleton, so if there is data related to the port Borderbot will create a hash key/value with the port data, but if there is no valid data value ex.(N/A, null) it will be excluded, so Borderbot will return a Array optimized including only the meaningful data.

```

Port data sample **agent.ports[0][:data]**
```ruby
agent.ports[0][:data]
#=>        
{
             :commercial => {
        :standard_lanes => {
            :operational_status => "no delay",
                    :lanes_open => 2,
                 :delay_minutes => 5
        },
            :FAST_lanes => {
            :operational_status => "no delay",
                    :lanes_open => 1,
                 :delay_minutes => 0
        }
    },
              :passenger => {
        :NEXUS_SENTRI_lanes => {
            :operational_status => "no delay",
                    :lanes_open => 1,
                 :delay_minutes => 0
        },
               :ready_lanes => {
            :operational_status => "delay",
                    :lanes_open => 4,
                 :delay_minutes => 10
        },
            :standard_lanes => {
            :operational_status => "delay",
                    :lanes_open => 2,
                 :delay_minutes => 15
        }
    },
             :pedestrian => {
        :standard_lanes => {
            :operational_status => "no delay",
                    :lanes_open => 2,
                 :delay_minutes => 0
        }
    },
    :construction_notice => {
        :"#cdata-section" => "Calexico/East Ready Lane is open west side of port; Passenger Hrs Mon-Fri 3:00AM to Midnight, Sat/Sun 6:00AM to Midnight. Go to www.getyouhome.gov for info.  Tune into AM 1610 for border crossing info"
    }
}
```


## Contributing to Borderbot gem

Bug reports and pull requests are welcome on GitHub at https://github.com/burguer80/borderbot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
