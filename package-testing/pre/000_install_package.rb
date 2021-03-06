test_name 'Install pdk package on workstation host' do
  workstation = find_at_most_one('workstation')

  step 'Install pdk package' do
    if workstation['platform'] =~ %r{windows}
      # BKR-1109 requests a neater way to install an MSI
      msi_url = "http://#{ENV['BUILD_SERVER']}/pdk/#{ENV['SHA']}/repos/windows/pdk-x64.msi"
      generic_install_msi_on(workstation, msi_url)
    else
      install_puppetlabs_dev_repo(workstation, 'pdk', ENV['SHA'], 'repo-config')
      workstation.install_package('pdk')
    end
  end
end
