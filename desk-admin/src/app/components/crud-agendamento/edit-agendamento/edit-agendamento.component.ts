import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CrudService } from 'src/app/shared/services/crud.service';
import { ActivatedRoute, Router } from '@angular/router';
import { Location } from '@angular/common';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-edit-agendamento',
  templateUrl: './edit-agendamento.component.html',
  styleUrls: ['./edit-agendamento.component.scss'],
})
export class EditAgendamentoComponent implements OnInit {
  editForm: FormGroup;

  constructor(
    private crudApi: CrudService,
    private fb: FormBuilder,
    private location: Location,
    private actRoute: ActivatedRoute,
    private router: Router,
    private toastr: ToastrService
  ) {}

  async ngOnInit() {
    this.updateAgendamentoData();
    const id = this.actRoute.snapshot.paramMap.get('id');
    (await this.crudApi.GetAgendamento(id)).valueChanges().subscribe((data: any) => {
      this.editForm.patchValue(data); // Use patchValue em vez de setValue
    });
  }  

  get nomeCliente() {
    return this.editForm.get('nomeCliente');
  }

  get data(){
    return this.editForm.get('data');
  }

  get horario(){
    return this.editForm.get('horario');
  }

  get servico(){
    return this.editForm.get('servico');
  }

  get cabelereiro(){
    return this.editForm.get('cabelereiro')
  }

  updateAgendamentoData() {
    this.editForm = this.fb.group({
      nomeCliente: ['', [Validators.required, Validators.minLength(2)]],
      data: [''],
      horario:[''], // Adicione a inicialização do controle dataAtual aqui, se necessário
      servico: [''],  // Adicione os outros controles do formulário, se necessário
      cabelereiro: [''],
    });
  }

  goBack() {
    this.location.back();
  }

  async updateForm() {
    
    await this.crudApi.UpdateAgendamento(this.editForm.value, this.actRoute.snapshot.paramMap.get('id'));
    this.toastr.success(
      this.editForm.controls['nomeCliente'].value + ' A edição foi um sucesso!'
    );
    this.router.navigate(['view-agendamento']);
  }

  async deleteForm(){
    await this.crudApi.DeleteAgendamento(this.actRoute.snapshot.paramMap.get('id'));
    
  }
}
