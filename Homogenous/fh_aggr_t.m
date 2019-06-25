function out = fh_aggr_t(xx)

global psi gamma taua taur tauw taui za zm z;
global yshare_a_data yshare_m_data yshare_x_data ;
global tshare_v_data tshare_b_data tshare_p_data tyratio_data ;
global mu_u mu_r mu_f ;
global abar beta delta alpha_s alpha_a alpha_a1 alpha_s1 alpha_s2 alpha_m ;
global dr ds dl pm pst zs;
global r wf w cur cf bur kf hu hr ha hs km hm ;
global ps pa ;
global pif pis cs_a cs_m cs_s BB OP OP1;
global out_v out_p out_b ;

taua = xx(1);
tauw = xx(2);
taur = xx(3);

% taua = exp(xx(1));
% tauw = exp(xx(2));
% taur = exp(xx(3));
taui = 0.365*taur ;

[eprice fval] = fsolve(@fh_ss,[ps,pa],OP1);

ps = eprice(1);
pa = eprice(2);

gov = BB(2) + taua*(pa*cs_a + cs_m)*cur ;

cur_a = cs_a*(cur-pa*(1+taua)*abar) + abar ;
cur_m = cs_m*(cur-pa*(1+taua)*abar) ;
cur_s = cs_s*(cur-pa*(1+taua)*abar) ;

cf_a = cs_a*(cf-pa*(1+taua)*abar) + abar ;
cf_m = cs_m*(cf-pa*(1+taua)*abar) ;
cf_s = cs_s*(cf-pa*(1+taua)*abar) ;

ca     = cur_a + mu_f*cf_a ;
cm     = cur_m + mu_f*cf_m ;
cs     = cur_s + mu_f*cf_s ;
aggcon = pa*ca + cm + ps*cs;

cshare_a = pa*ca/aggcon ;
cshare_m = cm/aggcon ;
cshare_s = ps*cs/aggcon ;

ys     = ps*mu_u*zs*(1-hu)^(1-alpha_s) ;
ya     = pa*(mu_r*za*(dr^alpha_a)*(1-hr)^(1-alpha_a) + ...
        mu_f*za*(ds^alpha_a1)*(ha^(1-alpha_a1)));
ym     = zm*(km^alpha_m)*(hm^(1-alpha_m));
yx     = mu_f*pst*z*(dl^alpha_s1)*(hs^alpha_s2)*(kf^(1-alpha_s1-alpha_s2));
agginv = delta*(km+mu_f*kf) ;

gdp_c = aggcon + agginv + gov ;
gdp_y = ya + ym + ys + yx ;

yshare_a = ya/gdp_y ;
yshare_m = ym/gdp_y ;
yshare_s = ys/gdp_y ;
yshare_x = yx/gdp_y ;

ptax   = tauw*(mu_u*w*hu + mu_r*wf*hr) ;
vtax   = taua*pa*ca + taua*cm ;
btax   = taui*ym + mu_f*taur*(pif+pis) ;
aggtax = ptax + vtax + btax ;

tshare_v = vtax/aggtax ;
tshare_p = ptax/aggtax ;
tshare_b = btax/aggtax ;
tyratio  = aggtax/gdp_y ;

out_v = aggtax/gdp_y - tyratio_data ;
% out_v = tshare_v - tshare_v_data ;
out_p = tshare_p - tshare_p_data ;
out_b = tshare_b - tshare_b_data ;

out = out_v^2 + out_p^2 + out_b^2 ;
% out = (out_v/tyratio_data)^2 +...
%     (out_p/tshare_p_data)^2 + (out_b/tshare_b_data)^2 ;

end