require 'fog/openstack'

Shindo.tests('Fog::Compute[:openstack] | volume requests', ['openstack']) do

  @volume_format = {
    'id'                 => String,
    'displayName'        => String,
    'size'               => Integer,
    'displayDescription' => String,
    'status'             => String,
    'snapshotId'         => String,
    'availabilityZone'   => String,
    'attachments'        => Array,
    'volumeType'         => NilClass,
    'createdAt'          => Time
  }


  tests('success') do
    tests('#list_volumes').formats({'volumes' => [@volume_format]}) do
      Fog::Compute[:openstack].list_volumes.body
    end

    tests('#get_volume_detail').formats({'volume' => @volume_format}) do
      pending unless Fog.mocking?
      Fog::Compute[:openstack].get_volume_details(0).body
    end

    tests('#create_volume').formats({'volume' => @volume_format}) do
      pending unless Fog.mocking?
      Fog::Compute[:openstack].create_volume('loud', 'this is a loud volume', 3).body
    end

    tests('#delete_volume').succeeds do
      pending unless Fog.mocking?
      Fog::Compute[:openstack].delete_volume(1)
    end
  end
end
