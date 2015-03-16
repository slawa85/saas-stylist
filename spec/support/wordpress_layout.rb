shared_context 'rendering into wordpress template' do
  def stub_wordpress_template(options)
    return unless options[:status]
    stub_request(:get, multitenancy_config['styling']['error_layout']['url'])
      .to_return(status: options[:status], body: options[:body], headers: {})
  end

  let(:multitenancy_config) do
    {
      'styling' =>
        {
          'error_layout' =>
            {
              'url' => 'http://example.com/error-404',
              'minimum_length' => 5,
              'read_options' => {},
              'place_holder' => "<div id='op-sass-content'></div>"
            }
        }
    }
  end
  before do
    allow(OpenProject::Configuration)
      .to receive(:[])
      .and_return(multitenancy_config)

    options = defined?(wordpress_loading_options) ? wordpress_loading_options : {
      status: 200,
      body: "stubbed WordPress response #{multitenancy_config['styling']['error_layout']['place_holder']}"
    }
    stub_wordpress_template(options)
  end

  let(:wordpress_template_phrase) { 'WordPress' }

  it 'renders normally' do
    expect(body).to include(wordpress_template_phrase)
  end

  shared_examples 'fallback layout' do
    it do
      expect(body).to include('<!-- fallback layout-->')
      expect(body).to_not include(wordpress_template_phrase)
    end
  end

  context 'loading with timeout' do
    let(:wordpress_loading_options) do
      allow_any_instance_of(SaasStylist::StylizedController)
        .to receive(:download_template).and_raise(Timeout::Error)
      expect(Rails.logger).to receive(:error).with(/timeout/i)

      { status: nil }
    end

    it_behaves_like 'fallback layout'
  end

  context 'loading with 404' do
    let(:wordpress_loading_options) do
      expect(Rails.logger).to receive(:error).with(/404/i)

      { status: 404, body: '' }
    end

    it_behaves_like 'fallback layout'
  end

  context 'loading with unexpected exception' do
    let(:wordpress_loading_options) do
      allow_any_instance_of(SaasStylist::StylizedController)
        .to receive(:download_template).and_raise(StandardError)
      expect(Rails.logger).to receive(:error).with(/unexpected exception/i)

      { status: nil }
    end

    it_behaves_like 'fallback layout'
  end

  context 'loading with insufficient length' do
    let(:wordpress_loading_options) do
      { status: 200, body: '', minimum_length: 3000 }
    end

    it_behaves_like 'fallback layout'
  end
end
