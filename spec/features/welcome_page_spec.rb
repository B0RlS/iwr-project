require 'rails_helper'

RSpec.feature 'user visit welcome page' do
  scenario 'after clicking "GET STARTED" button user appears on "Login" window',
  :js do

    visit root_path
    click_button 'Get Started'
    expect(find('#loginlayunder')).to be_visible
    within('#loginlayunder') do
      expect(page).to have_content 'Login'
    end
  end

  scenario 'after clicking "Register!" link user appears on "Registration"
  window', :js do

    visit root_path
    click_button 'Get Started'
    find('#register').click
    expect(find('#registerlay')).to be_visible
    expect(page).to have_content 'Registration'
  end

  scenario 'after clicking "Login" link user back to "Login" window', :js do

    visit root_path
    click_button 'Get Started'
    find('#register').click
    find('#loginback').click
    expect(find('#loginlay')).to be_visible
    expect(page).to have_content 'Login'
  end

  scenario 'after clicking "Fogot your password?" link user appears on
  "Fogot password" window', :js do

    visit root_path
    click_button 'Get Started'
    find('#fogotpass').click
    expect(find('#resetlay')).to be_visible
    expect(page).to have_content 'Fogot password?'
  end

  scenario 'after clicking "Back" link user appears on "Login" window', :js do

    visit root_path
    click_button 'Get Started'
    find('#fogotpass').click
    find('#backmodal').click
    expect(find('#loginlay')).to be_visible
    expect(page).to have_content 'Login'
  end
end
