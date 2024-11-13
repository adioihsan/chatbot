import { useEffect, useRef, useState } from 'react'
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout';
import { Head } from '@inertiajs/react';
import { IoMdAttach } from "react-icons/io";
import { IoIosSend } from "react-icons/io";
import { IoClose } from "react-icons/io5";
import { FaFileAlt } from "react-icons/fa";
import { AiOutlineLoading3Quarters } from "react-icons/ai";
import { router } from '@inertiajs/react'

export default function Dashboard({response}) {
    const [selectedChat,setSelectedChat] = useState();
    const [chatData,setChatData] = useState({
        files:[],
        prompt:""
    })
    const [versionRoute,setVersionRoute] = useState("/chat/send/v1")
    const [chatHistory,setChatHistory] = useState([]);
    const [isLoading,setIsLoading] = useState(false);
    const fileRef = useRef(null);

    const handleField = (e)=>{
        if(e.target.type === "file"){
            setChatData(prev => ({...prev,[e.target.name]: Array.from(e.target.files)}))
        }else{
            setChatData(prev => ({...prev,[e.target.name]: e.target.value}))
        }
    }

    const openFileDialog = (e)=>{
        e.stopPropagation();
        fileRef?.current?.click();
    }
    const sendPrompt = (e)=>{
        e.preventDefault();
        router.post(versionRoute,{prompt:chatData.prompt,file:chatData.files[0]}, {
            forceFormData: true,
          });
    }

    router.on("start",()=>{
        setIsLoading(true);
    })
    router.on("finish",()=>{
        setIsLoading(false);
  
    })
    useEffect(()=>{
        if(response?.length > 0){
            setChatHistory(prev=> [...prev, {prompt:` ${chatData.prompt} `,response}])
            setChatData({
                files:[],
                prompt:""
            });
        }
    },[response])

    return (
        <AuthenticatedLayout
            header={
                <div class="flex gap-3 items-center ">
                    <h2 className="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
                        ChatBot
                    </h2>
                    <select id="countries" onChange={(e)=>{setVersionRoute(e.target.value)}} 
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        <option value="/chat/send/v1">V1 - Parse File to text</option>
                        <option value="/chat/send/v2">V2 - Parse File to text using OCR </option>
                        <option value="/chat/send/v3">V3 - Parse File to image base64</option>
                        <option value="/chat/send/v4">V4 - Parse File to image url</option>
                        <option value="/chat/send/v5">V5 - Auto Parse File to text/image url</option>
                </select>
                </div>
            }
        >
            <Head title="General Chat" />
            <div className="py-12">
                <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
                    <h2 className={chatHistory.length < 1 ? 'text-center m-3 text-3xl font-semibold' : "hidden"}>Ask Me Anything</h2>
                        <div className={`overflow-hidden bg-white shadow-sm sm:rounded-lg dark:bg-gray-800 p-3 ${chatHistory.length > 0 && " bottom-5 fixed w-full max-w-7xl"}`}>
                            {chatData?.files?.map((file,index)=>
                             <div className='my-1 bg-blue-500 flex gap-2 p-3 items-center text-gray-100 rounded-md'>
                                    <FaFileAlt color="white" /> {file.name} <button type=" button" className='ml-auto' onClick={()=>setChatData((prev)=> prev.files.filter((f,i)=>i !== index))}><IoClose /></button>
                                </div>
                            )}
                            <form  onSubmit={sendPrompt} method='POST'>
                                <input type="file"  name="files" accept=".pdf" className='hidden' ref={fileRef} onChange={handleField}/>   
                                <label htmlFor="prompt" className="mb-2 text-sm font-medium text-gray-900 sr-only dark:text-white">Chat Me...</label>
                                <div className="relative">
                                    <button type='button' className="absolute inset-y-0 start-0 flex items-center ps-3" onClick={openFileDialog}>
                                        <IoMdAttach size={24}/>
                                    </button>
                                    <input type="text" id="prompt" name="prompt" value={chatData.prompt} onChange={handleField}  className="block w-full p-4 ps-10 text-sm text-gray-900 border border-gray-300 rounded-lg bg-gray-50 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 disabled:grayscale" placeholder="Chat Me..." required />
                             
                                    <button
                                        onClick={sendPrompt}
                                        disabled={chatData.prompt < 1 || isLoading}  type="submit" className="flex items-center justify-center text-white absolute end-2.5 rounded-[100%] bottom-2.5 bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium text-sm p-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800 disabled:grayscale">
                                        {!isLoading ? <IoIosSend size={18}/>:
                                        <AiOutlineLoading3Quarters  className='animate-spin' />}
                                    </button>
                                </div>
                            </form>
                        </div>

                    <div className='grid gap-6 pb-10'>
                        {chatHistory?.map((history,index)=>{
                            return (
                            <div className='mb-3'  key={"history-"+index}>
                                    <div  className=" overflow-hidden transition ease-in-out delay-150 bg-blue-50 shadow-sm sm:rounded-lg dark:bg-slate-600 p-3 mr-auto w-fit max-w-[90%] lg:max-w-[80%] mb-2">
                                        {history.prompt}
                                    </div>
                                    <div  className="overflow-hidden transition ease-in-out delay-150 bg-white shadow-sm sm:rounded-lg dark:bg-gray-800 p-3 ml-auto w-fit max-w-[90%]  lg:max-w-[80%] mb-2">
                                        {history.response}
                                    </div>
                            </div>)
                        })}
                    </div>

                </div>
            </div>
        </AuthenticatedLayout>
    );
}
