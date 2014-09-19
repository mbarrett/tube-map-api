require_relative '../../builders/QueryHashBuilder.rb'
require_relative '../../constants.rb'

describe QueryHashBuilder do
	describe QueryHashBuilder, '.build' do
		context 'without querystring params' do
			let(:expected) {{ :pid => PID_CONST}}
			let(:subject) { QueryHashBuilder.new({}) }

			it 'should only return the PID' do
				expect(subject.build).to eq(expected)
			end
		end
	end

	describe QueryHashBuilder, '.build' do
		context 'with querystring params' do
			let(:expected) {{ :rid => 1234, :pid => PID_CONST}}
			let(:subject) { QueryHashBuilder.new({:rid => 1234}) }

			it 'should return the querystring params with PID appended' do
				expect(subject.build).to eq(expected)
			end
		end
	end
end