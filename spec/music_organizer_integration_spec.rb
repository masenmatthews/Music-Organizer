require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('button adds artists to list', {:type => :feature}) do
  it('takes text input and adds it to a list') do
    visit('/')
    fill_in('artist', :with => 'Radiohead')
    click_button('Submit')
    expect(page).to have_content('Radiohead')
  end
end

describe('clear button removes artist inputs from field', {:type => :feature}) do
  it('removes all user inputs from list') do
    visit('/')
    fill_in('artist', :with => 'Radiohead')
    click_button('clear')
    expect(page.has_content?('Radiohead')).to(eq(false))
  end
end

describe('album page', {:type => :feature}) do
  it('adds albums to list') do
    visit('/')
    fill_in('artist', :with => 'Gaga')
    click_button('Submit')
    click_link('Gaga')
    expect(page).to have_content('Artist: Gaga')
    fill_in('album', :with => 'Joanne')
    click_button('Submit')
    expect(page).to have_content('Joanne')
  end
end
