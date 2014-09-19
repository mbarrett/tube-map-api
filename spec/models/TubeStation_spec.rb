require_relative '../../models/TubeStation.rb'

describe TubeStation do
	let(:name) {'Canonbury'}
	let(:lat) {'51.548188'}
	let(:long) {'-0.09256'}
	let(:zone) {'2'}

	let(:subject) { TubeStation.new(:name, :lat, :long, :zone) }

	describe '#name' do
		context 'when requesting the name' do
			it 'should assign the correct tube station name' do
				subject.name.should eq(:name)
			end
		end
	end

	describe '#lat' do
		context 'when requesting the latitude' do
			it 'should assign the correct latitude' do
				subject.lat.should eq(:lat)
			end
		end
	end

	describe '#long' do
		context 'when requesting the longitude' do
			it 'should assign the correct longitude' do
				subject.long.should eq(:long)
			end
		end
	end

	describe '#zone' do
		context 'when requesting the zone' do
			it 'should assign the correct zone' do
				subject.zone.should eq(:zone)
			end
		end
	end
end