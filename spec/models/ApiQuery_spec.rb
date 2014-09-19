require_relative '../../models/ApiQuery.rb'

describe ApiQuery do
	let(:http_method) {'GET'}
	let(:method_to_call) {'/restaurant'}
	let(:querystring_params) {{ :rid => 1234 }}
	let(:body_params) {{ :email => "test@test.com"}}

	let(:subject) { ApiQuery.new(:http_method, :method_to_call, :querystring_params, :body_params) }

	describe '#http_method' do
		context 'when requesting http_method' do
			it 'should return GET as the HTTP method' do
				expect(subject.http_method).to eq(:http_method)
			end
		end
	end

	describe '#method_to_call' do
		context 'when requesting method_to_call' do
			it 'should return the method to call' do
				expect(subject.method_to_call).to eq(:method_to_call)
			end
		end
	end

	describe '#querystring_params' do
		context 'when requesting querystring_params' do
			it 'should return the querystring params' do
				expect(subject.querystring_params).to eq(:querystring_params)
			end
		end
	end

	describe '#body_params' do
		context 'when requesting body_params' do
			it 'should return the body params' do
				expect(subject.body_params).to eq(:body_params)
			end
		end
	end
end