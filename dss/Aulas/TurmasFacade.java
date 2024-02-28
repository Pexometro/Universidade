public class SSGesTurmasFacade {

    Public Aluno getAluno(String codAluno) {

        Aluno res = null;
        res = this.alunos.get(codAluno);

        if (res != null)
            return res.clone();


        return res;
    }


    public boolean validaAvaliadores() {
        
        boolean flag = true;

        for(Grupo g : this.grupos && flag = true) {

            flag = g.validaAvaliadoresAux();

            }
        return flag;

        } 
}
