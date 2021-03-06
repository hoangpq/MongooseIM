# Flat options format

`'FLAT'` means that the value was separated into more options. For example,
module options are separated into a list of `module_opt`-s.

Each flat option key starts with an option type:

- `l` - local options
- `h` - local host options
- `g` - global options

# Flat options example

```erlang
{[l,listen],'FLAT'}.
{[l,listener,{5280,{0,0,0,0},tcp},ejabberd_cowboy],'FLAT'}.
{[l,listener_opt,{5280,{0,0,0,0},tcp},ejabberd_cowboy,num_acceptors],10}.
{[l,listener_opt,{5280,{0,0,0,0},tcp},ejabberd_cowboy,transport_options],
 [{max_connections,1024}]}.
{[l,listener_opt,{5280,{0,0,0,0},tcp},ejabberd_cowboy,modules],
 [{"_","/http-bind",mod_bosh},
  {"_","/ws-xmpp",mod_websockets,
   [{ejabberd_service,[{access,all},
                       {shaper_rule,fast},
                       {ip,{127,0,0,1}},
                       {password,"secret"}]}]}]}.
{[l,listener,{5285,{0,0,0,0},tcp},ejabberd_cowboy],'FLAT'}.
{[l,listener_opt,{5285,{0,0,0,0},tcp},ejabberd_cowboy,num_acceptors],10}.
{[l,listener_opt,{5285,{0,0,0,0},tcp},ejabberd_cowboy,transport_options],
 [{max_connections,1024}]}.
{[l,listener_opt,{5285,{0,0,0,0},tcp},ejabberd_cowboy,ssl],
 [{certfile,"priv/ssl/fake_cert.pem"},
  {keyfile,"priv/ssl/fake_key.pem"},
  {password,[]}]}.
{[l,listener_opt,{5285,{0,0,0,0},tcp},ejabberd_cowboy,modules],
 [{"_","/http-bind",mod_bosh},{"_","/ws-xmpp",mod_websockets,[]}]}.
{[l,listener,{8088,{127,0,0,1},tcp},ejabberd_cowboy],'FLAT'}.
{[l,listener_opt,{8088,{127,0,0,1},tcp},ejabberd_cowboy,num_acceptors],10}.
{[l,listener_opt,{8088,{127,0,0,1},tcp},ejabberd_cowboy,transport_options],
 [{max_connections,1024}]}.
{[l,listener_opt,{8088,{127,0,0,1},tcp},ejabberd_cowboy,modules],
 [{"localhost","/api",mongoose_api_admin,[]}]}.
{[l,listener,{8089,{0,0,0,0},tcp},ejabberd_cowboy],'FLAT'}.
{[l,listener_opt,{8089,{0,0,0,0},tcp},ejabberd_cowboy,num_acceptors],10}.
{[l,listener_opt,{8089,{0,0,0,0},tcp},ejabberd_cowboy,transport_options],
 [{max_connections,1024}]}.
{[l,listener_opt,{8089,{0,0,0,0},tcp},ejabberd_cowboy,protocol_options],
 [{compress,true}]}.
{[l,listener_opt,{8089,{0,0,0,0},tcp},ejabberd_cowboy,ssl],
 [{certfile,"priv/ssl/fake_cert.pem"},
  {keyfile,"priv/ssl/fake_key.pem"},
  {password,[]}]}.
{[l,listener_opt,{8089,{0,0,0,0},tcp},ejabberd_cowboy,modules],
 [{"_","/api/sse",lasse_handler,[mongoose_client_api_sse]},
  {"_","/api/messages/[:with]",mongoose_client_api_messages,[]},
  {"_","/api/contacts/[:jid]",mongoose_client_api_contacts,[]},
  {"_","/api/rooms/[:id]",mongoose_client_api_rooms,[]},
  {"_","/api/rooms/:id/users/[:user]",mongoose_client_api_rooms_users,[]},
  {"_","/api/rooms/[:id]/messages",mongoose_client_api_rooms_messages,[]}]}.
{[l,listener,{5288,{127,0,0,1},tcp},ejabberd_cowboy],'FLAT'}.
{[l,listener_opt,{5288,{127,0,0,1},tcp},ejabberd_cowboy,num_acceptors],10}.
{[l,listener_opt,{5288,{127,0,0,1},tcp},ejabberd_cowboy,transport_options],
 [{max_connections,1024}]}.
{[l,listener_opt,{5288,{127,0,0,1},tcp},ejabberd_cowboy,modules],
 [{"localhost","/api",mongoose_api,
   [{handlers,[mongoose_api_metrics,mongoose_api_users]}]}]}.
{[l,listener,{5222,{0,0,0,0},tcp},ejabberd_c2s],'FLAT'}.
{[l,listener_opt,{5222,{0,0,0,0},tcp},ejabberd_c2s,certfile],
 "priv/ssl/fake_server.pem"}.
{[l,listener_simple_opt,{5222,{0,0,0,0},tcp},ejabberd_c2s,starttls],simple}.
{[l,listener_opt,{5222,{0,0,0,0},tcp},ejabberd_c2s,zlib],10000}.
{[l,listener_opt,{5222,{0,0,0,0},tcp},ejabberd_c2s,access],c2s}.
{[l,listener_opt,{5222,{0,0,0,0},tcp},ejabberd_c2s,shaper],c2s_shaper}.
{[l,listener_opt,{5222,{0,0,0,0},tcp},ejabberd_c2s,max_stanza_size],65536}.
{[l,listener_opt,{5222,{0,0,0,0},tcp},ejabberd_c2s,protocol_options],
 ["no_sslv3"]}.
{[l,listener_opt,{5222,{0,0,0,0},tcp},ejabberd_c2s,dhfile],
 "priv/ssl/fake_dh_server.pem"}.
{[l,listener,{5223,{0,0,0,0},tcp},ejabberd_c2s],'FLAT'}.
{[l,listener_opt,{5223,{0,0,0,0},tcp},ejabberd_c2s,zlib],4096}.
{[l,listener_opt,{5223,{0,0,0,0},tcp},ejabberd_c2s,access],c2s}.
{[l,listener_opt,{5223,{0,0,0,0},tcp},ejabberd_c2s,shaper],c2s_shaper}.
{[l,listener_opt,{5223,{0,0,0,0},tcp},ejabberd_c2s,max_stanza_size],65536}.
{[l,listener,{5269,{0,0,0,0},tcp},ejabberd_s2s_in],'FLAT'}.
{[l,listener_opt,{5269,{0,0,0,0},tcp},ejabberd_s2s_in,shaper],s2s_shaper}.
{[l,listener_opt,{5269,{0,0,0,0},tcp},ejabberd_s2s_in,max_stanza_size],131072}.
{[l,listener_opt,{5269,{0,0,0,0},tcp},ejabberd_s2s_in,protocol_options],
 ["no_sslv3"]}.
{[l,listener_opt,{5269,{0,0,0,0},tcp},ejabberd_s2s_in,dhfile],
 "priv/ssl/fake_dh_server.pem"}.
{[l,listener,{8888,{127,0,0,1},tcp},ejabberd_service],'FLAT'}.
{[l,listener_opt,{8888,{127,0,0,1},tcp},ejabberd_service,access],all}.
{[l,listener_opt,{8888,{127,0,0,1},tcp},ejabberd_service,shaper_rule],fast}.
{[l,listener_opt,{8888,{127,0,0,1},tcp},ejabberd_service,password],"secret"}.
{[l,listener,{8189,{127,0,0,1},tcp},ejabberd_service],'FLAT'}.
{[l,listener_opt,{8189,{127,0,0,1},tcp},ejabberd_service,access],all}.
{[l,listener_opt,{8189,{127,0,0,1},tcp},ejabberd_service,hidden_components],
 true}.
{[l,listener_opt,{8189,{127,0,0,1},tcp},ejabberd_service,shaper_rule],fast}.
{[l,listener_opt,{8189,{127,0,0,1},tcp},ejabberd_service,password],"secret"}.
{[l,all_metrics_are_global],false}.
{[l,s2s_certfile],"priv/ssl/fake_server.pem"}.
{[l,node_start],{1530,15976,143119}}.
{[l,odbc_pools],[]}.
{[l,registration_timeout],infinity}.
{[l,outgoing_s2s_port],5299}.
{[l,services],
 [{service_admin_extra,[{submods,[node,accounts,sessions,vcard,roster,last,
                                  private,stanza,stats]}]}]}.
{[l,max_fsm_queue],1000}.
{[l,s2s_use_starttls],optional}.
{[h,<<"anonymous.localhost">>,auth_method],anonymous}.
{[h,<<"anonymous.localhost">>,s2s_default_policy],allow}.
{[h,<<"localhost.bis">>,modules],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_carboncopy],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_stream_management],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_muc_commands],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_amp],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_offline],'FLAT'}.
{[h,<<"localhost.bis">>,module_opt,mod_offline,access_max_user_messages],
 max_user_offline_messages}.
{[h,<<"localhost.bis">>,module,mod_last],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_roster],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_bosh],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_blocking],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_vcard],'FLAT'}.
{[h,<<"localhost.bis">>,module_opt,mod_vcard,host],"vjud.@HOST@"}.
{[h,<<"localhost.bis">>,module,mod_muc_light_commands],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_commands],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_disco],'FLAT'}.
{[h,<<"localhost.bis">>,module_opt,mod_disco,users_can_see_hidden_services],
 false}.
{[h,<<"localhost.bis">>,module,mod_privacy],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_private],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_sic],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_adhoc],'FLAT'}.
{[h,<<"localhost.bis">>,module,mod_register],'FLAT'}.
{[h,<<"localhost.bis">>,module_opt,mod_register,welcome_message],{[]}}.
{[h,<<"localhost.bis">>,module_opt,mod_register,ip_access],'FLAT'}.
{[h,<<"localhost.bis">>,module_subopt,mod_register,ip_access,allow],
 "127.0.0.0/8"}.
{[h,<<"localhost.bis">>,module_subopt,mod_register,ip_access,deny],
 "0.0.0.0/0"}.
{[h,<<"localhost.bis">>,module_opt,mod_register,access],register}.
{[h,<<"localhost">>,modules],'FLAT'}.
{[h,<<"localhost">>,module,mod_carboncopy],'FLAT'}.
{[h,<<"localhost">>,module,mod_stream_management],'FLAT'}.
{[h,<<"localhost">>,module,mod_muc_commands],'FLAT'}.
{[h,<<"localhost">>,module,mod_amp],'FLAT'}.
{[h,<<"localhost">>,module,mod_offline],'FLAT'}.
{[h,<<"localhost">>,module_opt,mod_offline,access_max_user_messages],
 max_user_offline_messages}.
{[h,<<"localhost">>,module,mod_last],'FLAT'}.
{[h,<<"localhost">>,module,mod_roster],'FLAT'}.
{[h,<<"localhost">>,module,mod_bosh],'FLAT'}.
{[h,<<"localhost">>,module,mod_blocking],'FLAT'}.
{[h,<<"localhost">>,module,mod_vcard],'FLAT'}.
{[h,<<"localhost">>,module_opt,mod_vcard,host],"vjud.@HOST@"}.
{[h,<<"localhost">>,module,mod_muc_light_commands],'FLAT'}.
{[h,<<"localhost">>,module,mod_commands],'FLAT'}.
{[h,<<"localhost">>,module,mod_disco],'FLAT'}.
{[h,<<"localhost">>,module_opt,mod_disco,users_can_see_hidden_services],false}.
{[h,<<"localhost">>,module,mod_privacy],'FLAT'}.
{[h,<<"localhost">>,module,mod_private],'FLAT'}.
{[h,<<"localhost">>,module,mod_sic],'FLAT'}.
{[h,<<"localhost">>,module,mod_adhoc],'FLAT'}.
{[h,<<"localhost">>,module,mod_register],'FLAT'}.
{[h,<<"localhost">>,module_opt,mod_register,welcome_message],{[]}}.
{[h,<<"localhost">>,module_opt,mod_register,ip_access],'FLAT'}.
{[h,<<"localhost">>,module_subopt,mod_register,ip_access,allow],"127.0.0.0/8"}.
{[h,<<"localhost">>,module_subopt,mod_register,ip_access,deny],"0.0.0.0/0"}.
{[h,<<"localhost">>,module_opt,mod_register,access],register}.
{[h,<<"localhost">>,auth_method],internal}.
{[h,<<"anonymous.localhost">>,auth_opts],[]}.
{[h,<<"fed1">>,s2s_addr],{127,0,0,1}}.
{[h,<<"localhost.bis">>,auth_opts],[]}.
{[h,<<"localhost">>,auth_opts],[]}.
{[h,<<"anonymous.localhost">>,modules],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_carboncopy],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_stream_management],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_muc_commands],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_amp],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_offline],'FLAT'}.
{[h,<<"anonymous.localhost">>,module_opt,mod_offline,access_max_user_messages],
 max_user_offline_messages}.
{[h,<<"anonymous.localhost">>,module,mod_last],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_roster],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_bosh],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_blocking],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_vcard],'FLAT'}.
{[h,<<"anonymous.localhost">>,module_opt,mod_vcard,host],"vjud.@HOST@"}.
{[h,<<"anonymous.localhost">>,module,mod_muc_light_commands],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_commands],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_disco],'FLAT'}.
{[h,<<"anonymous.localhost">>,module_opt,mod_disco,
  users_can_see_hidden_services],
 false}.
{[h,<<"anonymous.localhost">>,module,mod_privacy],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_private],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_sic],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_adhoc],'FLAT'}.
{[h,<<"anonymous.localhost">>,module,mod_register],'FLAT'}.
{[h,<<"anonymous.localhost">>,module_opt,mod_register,welcome_message],{[]}}.
{[h,<<"anonymous.localhost">>,module_opt,mod_register,ip_access],'FLAT'}.
{[h,<<"anonymous.localhost">>,module_subopt,mod_register,ip_access,allow],
 "127.0.0.0/8"}.
{[h,<<"anonymous.localhost">>,module_subopt,mod_register,ip_access,deny],
 "0.0.0.0/0"}.
{[h,<<"anonymous.localhost">>,module_opt,mod_register,access],register}.
{[h,<<"anonymous.localhost">>,allow_multiple_connections],true}.
{[h,<<"localhost.bis">>,auth_method],internal}.
{[h,<<"localhost.bis">>,s2s_default_policy],allow}.
{[h,<<"localhost">>,s2s_default_policy],allow}.
{[h,<<"anonymous.localhost">>,anonymous_protocol],both}.
```
