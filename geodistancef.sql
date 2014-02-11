-- Function: geo_distance(double precision, double precision, double precision, double precision)

-- DROP FUNCTION geo_distance(double precision, double precision, double precision, double precision);
CREATE OR REPLACE FUNCTION geo_distance(longitude1 double precision, longitude2 double precision, latitude1 double precision, latitude2 double precision)
  RETURNS double precision AS
$BODY$
DECLARE 
delta_longitude DOUBLE PRECISION;
arc_val DOUBLE PRECISION;
chain1 DOUBLE PRECISION;
chain2 DOUBLE PRECISION;
chain3 DOUBLE PRECISION;
result DOUBLE PRECISION;
BEGIN

delta_longitude:=@(longitude1-longitude2);
chain1:=(cos(latitude2)*sin(delta_longitude))^2;
chain2:=(cos(latitude1)*sin(latitude2)-sin(latitude1)*cos(latitude2)*cos(delta_longitude))^2;
chain3:=sin(latitude1)*sin(latitude2)+cos(latitude1)*cos(latitude2)*cos(delta_longitude);
arc_val:=(|/(chain1+chain2))/chain3;
result:= 6335.439*arc_val;
 return result;
END;$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
ALTER FUNCTION geo_distance(double precision, double precision, double precision, double precision)
  OWNER TO postgres;
