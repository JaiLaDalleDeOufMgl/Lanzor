function _GamemodeLabos:SaveLabo()
    MySQL.Async.execute("UPDATE labos SET accesList=@accesList,memberList=@memberList,drugsData=@drugsData WHERE id = @id", {
        ["@id"] = self.id,
        ["@accesList"] = json.encode(self.AccesList),
        ['@memberList'] = json.encode(self.memberList),
        ['@drugsData'] = json.encode(self.Drug:GetLabDrugData())
    })
end