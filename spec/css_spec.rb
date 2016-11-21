require 'spec_helper'
require_relative '../lib/open_classes/fixnum'
require_relative '../lib/open_classes/string'

describe Css do

  it 'parse different selectors' do
    css = Css.new.stylesheet do
      body
      _class {}
      __id
      div_class
      h1__id {}
    end

    css_expected = 'body { }; .class { }; #id { }; div.class { }; h1#id { };'

    expect(css.compiled.minify).to eq css_expected
  end

  it 'compile simple tag-rule with one declaration' do
    css = Css.new.stylesheet do
      body {
        fontSize 16.px
      }
    end

    css_expected = 'body { fontSize: 16px; };'

    expect(css.compiled.minify).to eq css_expected
  end

end
