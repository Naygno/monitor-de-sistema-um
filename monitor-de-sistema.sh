#!/bin/bash


i=0 # Informa se o usuário está acessando o menu mais de uma vez na sessão atual.

while true; do

	echo
	echo "=== Monitorar Processos (I) ==="
	echo "Opções:"
	echo "1) Consumo de CPU"
	echo "2) Consumo de MEM"
	echo "3) Status de Processo"
	echo "4) Relatóiro de erros de log"
	echo "5) Automatizar 4)"
	echo "6) Sair"
	echo "==============================="
	echo

	if [[ $i -eq 0 ]]; then
		read -e -p "Escolha uma opção [1-6]: " opcao # A opção "-e" habilita a navagação pelas setas e evita caracteres estranhos.
	else
		read -e -p "Escolha outra opção [1-6]: " opcao
	fi

	if [[ "$opcao" =~ ^[a-zA-Z07-9_-]+$ ]]; then # Verifica se a opção é válida.
		echo "Opção inválida!"
		i=$((i+1))
	else
		i=$((i+1))
		case $opcao in

			'1')
				echo "Esta opção monitora o consumo de CPU"
				read -e -p "Digite (S)im para proceguir ou (N)ão para sair: " monitora_cpu

				case $monitora_cpu in

					'S'|'s')

						echo "Os 10 processos com maior consumindo de CPU"
						echo "== CPU  PROCESSO =="
						touch var_temporaria
						 
						ps -e -o %cpu,command --no-headers --sort=-%cpu | head -n 10 > var_temporaria
						status_ps=$?

						while read linha; do # Imprime os processo na tela.
							echo "   $linha"
						done < var_temporaria

						echo "==================="
						read -e -p "Escolha um processo para acompanhar: " processo

						while [[ ! "$processo" =~ ^[a-zA-Z]+$ ]]; do # Verifica se a entrada do usuário é válida.
							echo "Valor inválido."
							read -e -p "Escolha um processo para acompanhar: " processo
						done
						 
						case $status_ps in

							'0')
								grep "$processo" var_temporaria
								rm var_temporaria
								break
								;;

							'1')
								echo "Erro de execução."
								break
								;;
							
							*)
								echo "Valor inválido."
								read -e -p "Escolha um processo para acompanhar: " processo
								continue
								;;
						esac
						continue
						;;

					'N'|'n')

						 
						i=$((i+1))
						echo "Encerrando opção..."
						continue
						;;

					*)
						echo "Opção inválida."
						continue
						;;
				esac
				;;

			'2')
				read -e -p "Para prosseguir, indique a quantidade de linha que pretende visualizar [1-99]: " qtd_linhas

				while [[ ! $qtd_linhas =~ ^[1-9][0-9]?$ ]]; do # O caractere ? indica que o segundo dígito é opcional
					echo "Este campo só aceita números inteiros [1-99]."
					read -e -p "Indique um número: " qtd_linhas
				done

				echo "Processos com maior consumindo de MEM"
				echo "== MEM  PROCESSO =="

				touch var_temporaria
				ps -e -o %mem,command --no-headers --sort=-%mem | head -n $qtd_linhas > var_temporaria
				status_ps=$?

				while read linha; do # Imprime os processos na tela.
					echo "   $linha"
				done < var_temporaria

				echo "==================="
				rm var_temporaria

				continue
				;;

			'3')
				read -e -p "Digite o nome do processo: " processo


				while [[ ! "$processo" =~ ^[a-zA-Z]+$ ]]; do # Verifica se a entrada do usuário é válida.
					echo "Valor inválido."
					read -e -p "Escolha um processo para acompanhar: " processo
				done

				if pgrep $processo &> /dev/null; then
					echo "O status do processo $processo é ativo."
					echo "Data/Hora: $( date +"%d/%m/%Y às %H:%M:%S")"
				else
					echo "O status do processo $processo é não ativo."
					echo "Data/Hora: $( date +"%d/%m/%Y às %H:%M:%S")"
				fi

				continue
				;;

			'4')
				read -e -p "Indique o caminho do diretório de logs: " diretorio


				while [[ ! "$diretorio" =~ ^/  || ! -d "$diretorio" ]]; do
					echo "O caminho deve ser absoluto (começar com /)"
					read -e -p "Indique o caminho: " diretorio
					ls "$diretorio" > /dev/null 2>&1
					status_ls=$?
				done
				
				if [[ $status_ls -eq 1 ]]; then
					echo "Não foi possível acessar os logs."
					echo "Acesso negado ou diretório vazio."
					break
				else
					while true; do

						echo
						echo "=== NÍVEIS DE PRIORIDADE === "
						echo "Opções:"
						echo "	0) Emergência"
						echo "	1) Alerta"
						echo "	2) Crítico"
						echo "	3) Erro"
						echo "	4) Aviso"
						echo "	5) Notificação"
						echo "	6) Informação"
						echo "	7) Depuração"
						echo "============================="
						echo "Ou (S)air desta operação"
						echo "============================="

						read -e -p "Digite a opção: " opcao

						if [[ $opcao =~ ^[0-7] ]]; then

							read -e -p "Indique o tempo (h) anterior à sessão atual: " tempo
							read -e -p "Defina quantas linhas devem ser mostrada:  " qtd_linhas

							case $opcao in

								'0')
									echo "=== Logs de Nível Emergência ==="
									journalctl -p --emerg  "$tempo hour ago" | head -n $qtd_linhas > lista_temporaria
									while read linha; do # Imprime os processo na tela.
										echo "$linha"
									done < lista_temporaria
									echo "================================"
									continue
									;;

								'1')
									echo "=== Logs de Nível Alerta ==="
									journalctl -p --alert  "$tempo hour ago" | head -n $qtd_linhas > lista_temporaria
									while read linha; do # Imprime os processo na tela.
										echo "$linha"
									done < lista_temporaria
									echo "================================"

									continue
									;;

								'2')
									echo "=== Logs de Nível Crítico ==="
									journalctl -p --crit  "$tempo hour ago" | head -n $qtd_linhas > lista_temporaria
									while read linha; do # Imprime os processo na tela.
										echo "$linha"
									done < lista_temporaria
									echo "================================"

									continue
									;;

								'3')
									echo "=== Logs de Nível Erro ==="
									journalctl -p --err  "$tempo hour ago" | head -n $qtd_linhas > lista_temporaria
									while read linha; do # Imprime os processo na tela.
										echo "$linha"
									done < lista_temporaria
									echo "================================"

									continue
									;;

								'4')
									echo "=== Logs de Nível Aviso ==="
									journalctl -p --warning  "$tempo hour ago" | head -n $qtd_linhas > lista_temporaria
									while read linha; do # Imprime os processo na tela.
										echo "$linha"
									done < lista_temporaria
									echo "================================"

									continue
									;;

								'5')
									echo "=== Logs de Nível Notificação ==="
									journalctl -p --notice  "$tempo hour ago" | head -n $qtd_linhas > lista_temporaria
									while read linha; do # Imprime os processo na tela.
										echo "$linha"
									done < lista_temporaria
									echo "================================"

									continue
									;;

								'6')
									echo "=== Logs de Nível Informação ==="
									journalctl -p --info  "$tempo hour ago" | head -n $qtd_linhas > lista_temporaria
									while read linha; do # Imprime os processo na tela.
										echo "$linha"
									done < lista_temporaria
									echo "================================"

									continue
									;;

								'7')
									echo "=== Logs de Nível Depuração ==="
									journalctl -p --debug  "$tempo hour ago" | head -n $qtd_linhas > lista_temporaria
									while read linha; do # Imprime os processo na tela.
										echo "$linha"
									done < lista_temporaria
									echo "================================"
									continue
									;;
							esac

							while true; do
								read -e -p "Para exportar para csv: (S)sim ou (N)ão" csv_opcao
								var_temp=${csv_opcao}

								case $var_temp in

									'S'|'SIM')
										#Instrução
										continue
										;;

									'N'|'NAO'|'NÃO')

										continue
										;;

									*)
										echo "Valor inválido."
										continue
										;;
								esac


							done

						else
							var_temp=${opcao^^}

							if [[ $var_temp == "S" || $var_temp == "SAIR" ]]; then
								echo "Encerrando..."
								break
							else
								echo "Valor inválido."
								continue
							fi
						fi
					done
				fi
				;;

			'5')
				# Opção 5
				;;

			'6')
				echo "Encerrando o script..."
				break
				;;

			*)
				echo "Opção inválida!"
				continue
				;;

esac
	fi

done
