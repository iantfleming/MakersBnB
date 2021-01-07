feature 'log in' do
  scenario 'a user can log in' do
    User.create(firstname: 'Dennis', lastname: 'the Menace', email: 'test@example.com', password: 'password123')
    visit '/login'
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'password123')
    click_button('Log In')

    expect(page).to have_content "Welcome, Dennis"
  end
end