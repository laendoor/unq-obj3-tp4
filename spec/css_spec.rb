require 'spec_helper'
require_relative '../lib/open_classes/fixnum'

describe Css do

  it 'assert true' do
    expect(true).to be true
  end

  it 'compile simple tag-rule with one declaration' do
    css = Css.new.stylesheet do
      body {
        fontSize 16.px
      }
    end

    css_expected = %q{body {
  fontSize: 16px;
}
}

    expect(css.compiled).to eq css_expected
  end

  it 'parse class selector with .' do
    css = Css.new.stylesheet do
      clase! {
        font 20.px
      }
    end

    css_expected = %q{.clase {
  font: 20px;
}
}

    expect(css.compiled).to eq css_expected
  end

  it 'parse id selector with #' do
    css = Css.new.stylesheet do
      id? {
        font 20.px
      }
    end

    css_expected = %q{#id {
  font: 20px;
}
}

    expect(css.compiled).to eq css_expected
  end

end
