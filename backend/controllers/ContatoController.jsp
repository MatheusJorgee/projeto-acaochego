<%@page language="java" import="java.sql.*, javax.mail.*, javax.mail.internet.*, java.util.Properties" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String telefone = request.getParameter("telefone");
        String assunto = request.getParameter("assunto");
        String mensagem = request.getParameter("mensagem");

        if (nome == null || email == null || telefone == null || assunto == null || mensagem == null ||
            nome.isEmpty() || email.isEmpty() || telefone.isEmpty() || assunto.isEmpty() || mensagem.isEmpty()) {
            out.print("<script>alert('Todos os campos são obrigatórios!'); history.back();</script>");
            return;
        }

        Connection conexao = null;
        boolean emailEnviado = false;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/projeto2?serverTimezone=UTC";
            conexao = DriverManager.getConnection(url, "root", "");
            
            String sql = "INSERT INTO contatos (nome, email, telefone, assunto, mensagem, data_envio) VALUES (?, ?, ?, ?, ?, NOW())";
            PreparedStatement stmt = conexao.prepareStatement(sql);
            stmt.setString(1, nome);
            stmt.setString(2, email);
            stmt.setString(3, telefone);
            stmt.setString(4, assunto);
            stmt.setString(5, mensagem);
            
            stmt.executeUpdate();
            stmt.close();

            try {
                Properties props = new Properties();
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.ssl.protocols", "TLSv1.2");

                final String emailRemetente = "testeacaochego@gmail.com";
                final String senhaApp = "goxi cxse ggbe zjwj";

                Session mailSession = Session.getInstance(props, new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(emailRemetente, senhaApp);
                    }
                });

                Message msgUsuario = new MimeMessage(mailSession);
                msgUsuario.setFrom(new InternetAddress(emailRemetente, "Acãochego"));
                msgUsuario.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                msgUsuario.setSubject("Recebemos sua mensagem - Acãochego");
                
                String htmlUsuario = "<!DOCTYPE html>" +
                    "<html><body style='font-family: Arial, sans-serif; margin: 0; padding: 0;'>" +
                    "<div style='max-width: 600px; margin: 0 auto; background-color: #f5f5f5;'>" +
                    "<div style='background: linear-gradient(135deg, #5893f3 0%, #4a7dd8 100%); padding: 30px; text-align: center;'>" +
                    "<h1 style='color: white; margin: 0; font-size: 28px;'>ACÃOCHEGO</h1>" +
                    "<p style='color: white; margin: 10px 0 0 0; opacity: 0.9;'>Associação Protetora de Animais</p>" +
                    "</div>" +
                    "<div style='background-color: white; padding: 40px 30px;'>" +
                    "<h2 style='color: #5893f3; margin-top: 0;'>Olá, " + nome + "!</h2>" +
                    "<p style='color: #333; line-height: 1.6;'>Recebemos sua mensagem e agradecemos por entrar em contato com a Acãochego.</p>" +
                    "<p style='color: #333; line-height: 1.6;'>Nossa equipe analisará sua solicitação e retornará o mais breve possível.</p>" +
                    "<div style='background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin: 25px 0;'>" +
                    "<p style='margin: 0 0 10px 0; color: #666; font-size: 14px;'><strong>Resumo da sua mensagem:</strong></p>" +
                    "<table style='width: 100%;'>" +
                    "<tr><td style='padding: 5px 0; color: #666;'><strong>Assunto:</strong></td><td style='padding: 5px 0; color: #333;'>" + assunto + "</td></tr>" +
                    "<tr><td style='padding: 5px 0; color: #666;'><strong>Telefone:</strong></td><td style='padding: 5px 0; color: #333;'>" + telefone + "</td></tr>" +
                    "</table>" +
                    "<p style='margin: 15px 0 5px 0; color: #666; font-size: 14px;'><strong>Mensagem:</strong></p>" +
                    "<p style='margin: 0; color: #333; line-height: 1.6; padding: 10px; background-color: white; border-left: 3px solid #5893f3;'>" + mensagem + "</p>" +
                    "</div>" +
                    "<p style='color: #333; line-height: 1.6;'>Obrigado por fazer a diferença na vida de nossos animais! 🐾</p>" +
                    "<hr style='border: none; border-top: 1px solid #e0e0e0; margin: 30px 0;'>" +
                    "<p style='color: #999; font-size: 12px; text-align: center;'>Este é um e-mail automático. Por favor, não responda.</p>" +
                    "</div>" +
                    "</div>" +
                    "</body></html>";
                
                msgUsuario.setContent(htmlUsuario, "text/html; charset=UTF-8");
                Transport.send(msgUsuario);

                Message msgAdmin = new MimeMessage(mailSession);
                msgAdmin.setFrom(new InternetAddress(emailRemetente, "Sistema Acãochego"));
                msgAdmin.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailRemetente));
                msgAdmin.setSubject("🔔 Nova mensagem de contato - " + assunto);
                
                String htmlAdmin = "<!DOCTYPE html>" +
                    "<html><body style='font-family: Arial, sans-serif; margin: 0; padding: 0;'>" +
                    "<div style='max-width: 600px; margin: 0 auto; padding: 20px;'>" +
                    "<div style='background: linear-gradient(135deg, #5893f3 0%, #4a7dd8 100%); padding: 20px; border-radius: 8px 8px 0 0;'>" +
                    "<h2 style='color: white; margin: 0;'>📩 Nova Mensagem de Contato</h2>" +
                    "</div>" +
                    "<div style='background-color: white; padding: 30px; border: 1px solid #e0e0e0; border-top: none; border-radius: 0 0 8px 8px;'>" +
                    "<table style='width: 100%; border-collapse: collapse;'>" +
                    "<tr style='border-bottom: 1px solid #e0e0e0;'><td style='padding: 12px 10px; color: #666; width: 120px;'><strong>Nome:</strong></td><td style='padding: 12px 10px; color: #333;'>" + nome + "</td></tr>" +
                    "<tr style='border-bottom: 1px solid #e0e0e0;'><td style='padding: 12px 10px; color: #666;'><strong>E-mail:</strong></td><td style='padding: 12px 10px; color: #333;'><a href='mailto:" + email + "' style='color: #5893f3; text-decoration: none;'>" + email + "</a></td></tr>" +
                    "<tr style='border-bottom: 1px solid #e0e0e0;'><td style='padding: 12px 10px; color: #666;'><strong>Telefone:</strong></td><td style='padding: 12px 10px; color: #333;'><a href='tel:" + telefone + "' style='color: #5893f3; text-decoration: none;'>" + telefone + "</a></td></tr>" +
                    "<tr style='border-bottom: 1px solid #e0e0e0;'><td style='padding: 12px 10px; color: #666;'><strong>Assunto:</strong></td><td style='padding: 12px 10px; color: #333;'><span style='background-color: #5893f3; color: white; padding: 4px 12px; border-radius: 12px; font-size: 12px;'>" + assunto + "</span></td></tr>" +
                    "</table>" +
                    "<div style='margin-top: 25px;'>" +
                    "<p style='margin: 0 0 10px 0; color: #666; font-size: 14px;'><strong>Mensagem:</strong></p>" +
                    "<div style='background-color: #f8f9fa; padding: 20px; border-radius: 8px; border-left: 4px solid #5893f3;'>" +
                    "<p style='margin: 0; color: #333; line-height: 1.6; white-space: pre-wrap;'>" + mensagem + "</p>" +
                    "</div>" +
                    "</div>" +
                    "<div style='margin-top: 30px; padding: 15px; background-color: #e3f2fd; border-radius: 8px; text-align: center;'>" +
                    "<p style='margin: 0; color: #1976d2; font-size: 14px;'>💡 Não se esqueça de responder o mais breve possível!</p>" +
                    "</div>" +
                    "</div>" +
                    "</div>" +
                    "</body></html>";
                
                msgAdmin.setContent(htmlAdmin, "text/html; charset=UTF-8");
                Transport.send(msgAdmin);

                emailEnviado = true;

            } catch (MessagingException e) {
                System.err.println("Erro ao enviar e-mail: " + e.getMessage());
                e.printStackTrace();
            }

            response.sendRedirect(request.getContextPath() + "/frontend/pages/contato.html?sucesso=true");

        } catch (Exception e) {
            out.print("<script>alert('Erro ao processar contato: " + e.getMessage() + "'); history.back();</script>");
            e.printStackTrace();
        } finally {
            if (conexao != null) {
                try { conexao.close(); } catch (SQLException ignore) {}
            }
        }
    }
%>
