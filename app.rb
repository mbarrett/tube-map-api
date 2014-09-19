require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'json'
require 'httparty'
require 'securerandom'

require_relative 'builders/AuthorizationHeaderBuilder.rb'
require_relative 'builders/QueryHashBuilder.rb'

require_relative 'providers/ResponseProvider.rb'

require_relative 'repositories/TubeStationRepository.rb'

require_relative 'models/ApiQuery.rb'
require_relative 'models/TubeStation.rb'
require_relative 'models/TimeSlot.rb'

require_relative 'constants.rb'

before do
	content_type 'html'
end

get "/" do
	erb :index
end

get "/balls" do
	return "in your face"
end

get "/restaurant/:rid" do
	content_type 'application/json'

	api_query = ApiQuery.new('GET', 'restaurant/', { :rid => params[:rid] }, {})
	response = ResponseProvider.new(api_query).get_response

  	return response.body
end

get "/stations" do
	@stations = TubeStationRepository.new().Get
	erb :stations
end

get "/station/:name" do
	content_type 'application/json'

	stations = TubeStationRepository.new().Get

	stations.each do |station|
	  	if station.name.casecmp(params[:name]) == 0
	  		tomorrow = Date.today + 1

	  		api_query = ApiQuery.new('GET', 'table/',
	  											{
	  												:dt => tomorrow.strftime("%d/%m/%Y %H:%M"),
	  												:ps => "2",
	  												:lat => "#{station.lat}",
	  												:long => "#{station.long}",
	  												:miles => "#{station.zone}",
	  												:n => "10",
	  												:ccresults => "0"
	  											},
	  											{})

			response = ResponseProvider.new(api_query).get_response

  			return response.body
	  	end
	end

	status 404
end

get "/availability" do
	@rid = params[:rid]
	@partysize = params[:partysize]

	datetime = Time.parse(params[:datetime]).strftime("%d/%m/%Y %H:%M")

	api_query = ApiQuery.new('GET', 'table/',
											{
												:dt => datetime,
	  											:ps => @partysize,
	  											:rid => @rid
	  										},
	  										{})

	response = ResponseProvider.new(api_query).get_response

	data = JSON.parse(response.body)

	@resultskey = data['ResultsKey']
	@timeslots = []
	timeslotData = data['Timeslots']

	timeslotData.each_with_index do |attr, idx|
  		 @timeslots << TimeSlot.new(timeslotData[idx]['Time'], timeslotData[idx]['SecurityId'], timeslotData[idx]['Points'],timeslotData[idx]['OfferIds'])
	end

	erb :availability
end

post "/slotlock" do
	@rid = params[:rid]
	@partysize = params[:partysize]
	@resultskey = params[:resultskey]
	@securityid = params[:securityid]
	@datetime = Time.parse(params[:datetime]).strftime("%d/%m/%Y %H:%M")

	api_query = ApiQuery.new('POST', 'slotlock/', {},
												{
													:datetime => @datetime,
	  												:partysize => @partysize,
	  												:rid => @rid,
	  												:timesecurityID => @securityid,
	  												:resultskey => @resultskey
	  											})

	response = ResponseProvider.new(api_query).get_response
	data = JSON.parse(response.body)

	@slotlockid = data['SlotLockID']

	erb :reservation
end

post "/reservation/make" do
	content_type 'application/json'

	api_query = ApiQuery.new('POST', 'reservation/', {
														:st => "0"
													 },
  													 {
  													 	:RID => params[:rid],
  													 	:email_address => params[:email],
  													 	:datetime => params[:datetime],
  										 				:partysize => params[:partysize],
  										 				:phone => "02012345678",
  														:OTannouncementOption => "0",
  														:RestaurantEmailOption => "0",
  														:firstname => params[:firstname],
  														:lastname => params[:lastname],
  														:timesecurityID => params[:securityid],
  														:resultskey => params[:resultskey],
  														:slotlockid => params[:slotlockid],
  														:firsttimediner => "0",
  														:specialinstructions => "",
  														:authkey => "",
  														:points => "0",
  														:app_version => "",
  														:cclast4 => "",
  														:cccustuuid => "",
  														:cccustuuid => "",
  														:ccpmtuuid => "",
  														:cchttpstat => "",
  														:ccresphash => "",
  														:ccresptime => "",
  														:phcountrycode => "UK",
  														:offerid => "0",
  														:offerversion => "0",
  														:restrefid => ""
  													  })

	response = ResponseProvider.new(api_query).get_response

	return response.body
end