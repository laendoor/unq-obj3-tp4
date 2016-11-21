require 'spec_helper'

describe CssDSL do

  it 'compile selectors' do
    css = CssDSL.new.stylesheet do
      body
      _class {}
      __id
      div_class
      h1__id {}
    end

    css_expected = 'body { }; .class { }; #id { }; div.class { }; h1#id { };'

    expect(css.compile.minify).to eq css_expected
  end

  it 'compile body tag-rule with font-size declaration' do
    css = CssDSL.new.stylesheet do
      body {
        fontSize 16.px
      }
    end

    css_expected = 'body { font-size: 16px; };'

    expect(css.compile.minify).to eq css_expected
  end

end
