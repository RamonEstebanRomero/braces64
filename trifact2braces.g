LoadPackage("YangBaxter");

FromDiagonalCode2Generators:=function(g, genscode)
    local f, c, x, gens;
    
    f:=Factors(Size(g));
    c:=CoefficientsQadic(genscode, Maximum(f));
    if (Length(c) mod Length(f)) <> 0 then
        for x in [Length(c)+1..(QuoInt(Length(c), Length(f))+1)*Length(f)]
        do 
            c[x]:=0;
        od;
    fi;
    gens:=[];
    
    for x in [1..Length(c)/Length(f)] do
        gens[x]:=PcElementByExponents(Pcgs(g),c{(x-1)*Length(f)+[1..Length(f)]});
    od;
    return gens;
end;


FromTrifact2Skewbrace:=function(g)
    local l, t, ea, em;
    ea:=IsomorphismPermGroup(g!.K);
    em:=IsomorphismPermGroup(g!.C);
    
    
    l:=List(g!.D, t-> [Image(ea, ImageKProjection(g, t))^-1, Image(em, ImageCProjection(g, t))^-1]);
    

    
    return Skewbrace(l);
    
end;


FromRec2Trifact:=function(r)
    local g;
    g:=PcGroupCode(r.code, r.order);
    g!.D:=Subgroup(g, FromDiagonalCode2Generators(g, r.diagonal));
    g!.C:=Subgroup(g, GeneratorsOfGroup(g){[1..Length(GeneratorsOfGroup(g))/2]});
    g!.K:=Subgroup(g, GeneratorsOfGroup(g){[Length(GeneratorsOfGroup(g))/2+1..Length(GeneratorsOfGroup(g))]});
    return g;
end;
